//
//  FlagsChallengeQuestionView.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//

import Foundation

//
import SwiftUI
import Foundation


struct FlagsChallengeQuestionView: View {
    @StateObject var timer1 = CommonTimer(duration: 30) {
           print("Timer complete1!")
       }
    @StateObject var timer2 = CommonTimer(duration: 10) {
           print("Timer complete1!")
       }
    
    @State private var totalScore = 0
    @State private var showNextScreen = false
    @State private var selectStatus = false
    @State private var isDisabled = false
    @State private var QuestionIndex = 0
    @State private var SelectedID = 0
    @State private var countriesItems: [CountriesItems] = []
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Questions.answer_id, ascending: true)],
        animation: .default)
    private var AllQuestions: FetchedResults<Questions>
    
    
    var body: some View {
        
        NavigationStack {
            VStack() {
                VStack(spacing:10) {
                    HStack(spacing: 16) {
                        
                    }
                    .frame(height:60)
                    .frame(maxWidth: .infinity)
                    .background(Color.hexFF7043)
                    
                    
                }.padding(.bottom,20)
                
                
                VStack (spacing: 0){
                    
                    
                    // StrokedText(text: "FLAGS CHALLENGE")
                    FlagsHeaderView(title: "FLAGS CHALLENGE", timerValue: timer1.remainingTime)
                    
                    Divider().padding(.bottom,6)
                    
                    ZStack(alignment: .topLeading) {
                        VStack(spacing: 0) {
                            HStack {
                                TopLeftBadgeView(number: QuestionIndex+1)
                                Spacer()
                            }
                            Spacer()
                        }

                        VStack {
                            Spacer().frame(height: 20) // Push text a bit below the badge
                            Text("GUESS THE COUNTRY FROM THE FLAG ?")
                                .foregroundColor(.black)
                                .font(.custom("Inter28pt-SemiBold", size: 12))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .frame(maxWidth: .infinity)
//                  //  Text("GUESS THE COUNTRY FROM THE FLAG ?")
//
//                        .foregroundColor(.black)
//                        .padding(.top,10)
//                        .font(.custom("Inter28pt-SemiBold", size: 12))
                   // QustionNumberView(timerValue: QuestionIndex+1)
                    HStack(alignment: .center, spacing: 10) {
                        VStack(){
                            Image(AllQuestions[QuestionIndex].country_code ?? "")
                                .resizable()
                                .frame(width: 71, height: 57.57)
                               
                           }  .frame(width: 119, height: 89)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                        if countriesItems.count >= 4 {
                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    answerButton(title: countriesItems[0].country_name ?? "", Id : Int(countriesItems[0].id ?? 0), selectedID:$SelectedID, buttonID: 0)
                                    
                                    answerButton(title:  countriesItems[1].country_name ?? "", Id : Int(countriesItems[1].id ?? 0), selectedID:$SelectedID, buttonID: 1)
                                }
                                
                                HStack(spacing: 12) {
                                    answerButton(title:  countriesItems[2].country_name ?? "",Id : Int(countriesItems[2].id ?? 0), selectedID:$SelectedID, buttonID: 2)
                                    answerButton(title:  countriesItems[3].country_name ?? "",Id : Int(countriesItems[3].id ?? 0), selectedID:$SelectedID, buttonID: 3)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.top,20)
                        }else{
                            HStack(spacing: 12) {
                                answerButton(title:  "a",Id :0, selectedID:$SelectedID, buttonID: 0)
                                
                                answerButton(title:   "b",Id :0 , selectedID:$SelectedID, buttonID: 1)
                            }
                            
                            HStack(spacing: 12) {
                                answerButton(title:   "c",Id :0, selectedID:$SelectedID, buttonID: 2)
                                answerButton(title:  "d",Id :0, selectedID:$SelectedID, buttonID: 3)
                            }
                            Spacer()
                        }
                        
                    }
                    
                    
                  
                    
                }  .frame(width: UIScreen.main.bounds.width - 10, height: 215)
                
                    .background(Color.hexD9D9D9)
                    .cornerRadius(2)
                    .shadow(radius: 1)
                    .offset(y: -20)
                Spacer()
                  
            }
            NavigationLink(destination: FlagchallengeGameOverview(), isActive: $showNextScreen) {
                                EmptyView()
                            }
                            .hidden()
            
        }
        .onAppear {
            timer1.start()
        }
        .navigationBarBackButtonHidden(true)
            .onAppear(){
                countriesItems = (AllQuestions[QuestionIndex].countrylist as? Set<CountriesItems>)?.shuffled() ?? []
            }
            .onChange(of: QuestionIndex, perform: { value in
                countriesItems = (AllQuestions[QuestionIndex].countrylist as? Set<CountriesItems>)?.shuffled() ?? []
            })
            .onChange(of:  timer1.remainingTime) { newValue in
                if newValue == 0 {
                   
                  
                    isDisabled = false
                    selectStatus = false
                  
                    
                    timer1.reset()
                    timer1.start()
                    isDisabled = false
                    if QuestionIndex < AllQuestions.count - 1 {
                        QuestionIndex += 1
                    } else{
                        showNextScreen = true
                        timer1.pause()
                        timer2.pause()
                    }
                    print("Timer reached zero")
                               }
            }
        
            .onChange(of:  timer2.remainingTime) { newValue in
                if newValue == 0 {
                    
                  
                    isDisabled = false
                    selectStatus = false
                  
                    
                    timer1.reset()
                    timer1.start()
                    isDisabled = false
                    if QuestionIndex < AllQuestions.count - 1 {
                        QuestionIndex += 1
                      
                    }else{
                        showNextScreen = true
                        timer1.pause()
                        timer2.pause()
                    }
                    print("Timer2 reached zero")
                               }
            }
        
    }
    
    
    
    func answerButton(title: String, Id : Int ,selectedID: Binding<Int>, buttonID: Int) -> some View {
         
        var wrongSelection = false
        let CORRECT = "CORRECT"
        let WRONG = "WRONG"
        var answerId =    AllQuestions[QuestionIndex].answer_id
        var selectedTextColor =  Color.hex01C414
    
        var backgroundColor =  Color.clear
        var borderColor = Color.hex484848
        
        var foregroundColorForText = Color.black
        if Id == answerId &&  selectStatus == true {
            borderColor = Color.hex01C414
        }else{
            borderColor = Color.hex484848
        }
     
        
       
        
        if selectStatus == true{
            var    id = countriesItems[selectedID.wrappedValue].id
            countriesItems[selectedID.wrappedValue].id
            var country_name = countriesItems[selectedID.wrappedValue].country_name
            
            CoreDataHelper.shared.updateQuestionStatusFully(context: viewContext, countryCode:  AllQuestions[QuestionIndex].country_code ?? "", userAnswerID: answerId)
           if countriesItems[selectedID.wrappedValue].id == answerId{
                
            }else{
              
                if countriesItems[selectedID.wrappedValue].id == Id{
                    wrongSelection = true
                    foregroundColorForText = Color.white
                    backgroundColor = Color.hexFF7043
                }
                    
                    
            }
            
        }
        
        return Button(action: {
           
            
            print("Selected Index: \(buttonID)")
            selectedID.wrappedValue = buttonID
          if countriesItems[selectedID.wrappedValue].id ==  AllQuestions[QuestionIndex].answer_id
            {
              totalScore += 2
              print("totalScore = \(totalScore)")
            }
            selectStatus = true
            isDisabled = false
            isDisabled = true
            timer1.pause()
            timer2.reset()
            timer2.start()
        }) {
            VStack {
                Text(title)
                    .font(.custom("Inter28pt-SemiBold", size: 12))
                    .foregroundColor(foregroundColorForText)
                    .padding(.vertical, 10)
                    .frame(width: 102.5, height: 23.04)
                    .background(backgroundColor)
                    .cornerRadius(2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(borderColor, lineWidth: 1)
                    )
                if Id == answerId && selectStatus == true {
                    Text(CORRECT)
                        .font(.custom("Inter28pt-Regular", size: 7))
                        .foregroundColor(selectedTextColor)
                }else{
                   
                    Text(WRONG)
                        .font(.custom("Inter28pt-Regular", size: 7))
                        .foregroundColor( wrongSelection == true ? Color.hexFF0000 : .clear)
                   
                }
            }
        } .disabled(isDisabled)
    }
    
}




