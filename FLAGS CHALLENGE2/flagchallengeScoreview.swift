//
//  flagchallengeScoreview.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//
import SwiftUI
import Foundation


struct flagchallengeScoreview: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showNextScreen = false
    @State private var totalScore = 0
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
                    FlagsHeaderViewWithout(title: "FLAGS CHALLENGE", timerValue:00)
                    
                    Divider().padding(.bottom,30)
                    
                    HStack (spacing: 8){
                        Text("SCORE: ")
                        //.font(.system(size:18,weight: .bold))
                            .font(.custom("Inter28pt-Regular", size: 20))
                            .foregroundColor(Color.hexFF7043)
                        Text("\(totalScore)/30 ")
                        //.font(.system(size:18,weight: .bold))
                            .font(.custom("Inter28pt-SemiBold", size: 30))
                            .foregroundColor(Color.hex484848)
                        
                    }
                  
                    Spacer()
                }
                
                
                .frame(width: UIScreen.main.bounds.width - 10, height: 215)
                
                .background(Color.hexD9D9D9)
                .cornerRadius(2)
                .shadow(radius: 1)
                .offset(y: -20)
                
                
                Spacer()
                
            }
           
                .onAppear {
                     totalScore = CoreDataHelper.shared.getTotalScore(context: viewContext)
                    print(totalScore)
                }
            
            NavigationLink(destination: FlagsChallengeQuestionView(), isActive: $showNextScreen) {
                                EmptyView()
                            }
                            .hidden()
        } .navigationBarBackButtonHidden(true)
          
    }
}





