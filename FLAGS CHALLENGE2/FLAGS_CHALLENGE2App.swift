//
//  FLAGS_CHALLENGE2App.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 24/06/25.
//

import SwiftUI
import CoreData

@main
//struct FLAGS_CHALLENGE2App: App {
//    let persistenceController = PersistenceController.shared
//  
    struct FLAGS_CHALLENGE2App: App {
        let persistenceController = PersistenceController.shared

        init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(red: 1.0, green: 0.44, blue: 0.26, alpha: 1.0) // FF7043
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

            let navBar = UINavigationBar.appearance()
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            navBar.compactAppearance = appearance
            navBar.tintColor = .white
            loadQuestionsAndInsertOneByOne(context: persistenceController.container.viewContext)
            }

        var body: some Scene {
            WindowGroup {
                NavigationStack {
                    FlagsChallengeView()
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    

    func insertSingleQuestion(from dto: QuestionDTO, context: NSManagedObjectContext) {
        // Check if a question with the same country_code already exists
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country_code == %@", dto.country_code)

        do {
            let existing = try context.fetch(fetchRequest)

            if !existing.isEmpty {
                print("⚠️ Skipping insert: Question with country_code '\(dto.country_code)' already exists.")
                return
            }

            // If not found, insert new question
            let question = Questions(context: context)
            question.answer_id = Int16(dto.answer_id)
            question.country_code = dto.country_code

            for countryDTO in dto.countries {
                let country = CountriesItems(context: context)
                country.id = Int16(countryDTO.id)
                country.country_name = countryDTO.country_name
                country.questionlist = question
            }

            try context.save()
            print("✅ Saved question: \(dto.answer_id)")

        } catch {
            print("❌ Error checking or saving question: \(error)")
        }
    }
    
    
    func loadQuestionsAndInsertOneByOne(context: NSManagedObjectContext) {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("❌ File not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([QuestionDTO].self, from: data)

            for dto in decoded {
                insertSingleQuestion(from: dto, context: context)
            }
        } catch {
            print("❌ Failed to load and insert questions: \(error)")
        }
    }
}
