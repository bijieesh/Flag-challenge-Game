//
//  CoreDataHelper.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//

import Foundation
import CoreData
class CoreDataHelper {
    static let shared = CoreDataHelper()
    
    private init() {}
    
    let context = PersistenceController.shared.container.viewContext
    
    
    func updateQuestionStatusFully(
        context: NSManagedObjectContext,
        countryCode: String,
        userAnswerID: Int16
    ) {
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country_code == %@", countryCode)
        
        do {
            let questions = try context.fetch(fetchRequest)
            
            if let question = questions.first {
                // Update values
                question.selectionStatus = true
                question.viewStatus = true
                question.userAnser_id = userAnswerID
                question.score = (question.answer_id == userAnswerID) ? 2 : 0
                
                // Save changes
                try context.save()
                print("Updated question with country_code: \(countryCode)")
            } else {
                print("No question found for country_code: \(countryCode)")
            }
            
        } catch {
            print("Failed to update question: \(error)")
        }
    }
    
    
    func getTotalScore(context: NSManagedObjectContext) -> Int {
        let fetchRequest = NSFetchRequest<NSDictionary>(entityName: "Questions")
        
        // Filter only selected questions
        fetchRequest.predicate = NSPredicate(format: "selectionStatus == true")
        
        // Expression to sum the 'score' field
        let sumExpression = NSExpressionDescription()
        sumExpression.name = "totalScore"
        sumExpression.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "score")])
        sumExpression.expressionResultType = .integer32AttributeType
        
        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = [sumExpression]
        
        do {
            if let result = try context.fetch(fetchRequest).first,
               let total = result["totalScore"] as? Int {
                return total
            }
        } catch {
            print("Error calculating score: \(error)")
        }
        
        return 0
    }
}
