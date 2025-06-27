//
//  FlagchallengeGameOverview.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//

import Foundation

//  nextview.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 25/06/25.
//
import SwiftUI
import Foundation


struct FlagchallengeGameOverview: View {
    @StateObject var timer1 = CommonTimer(duration: 3) {
           print("Timer complete1!")
       }
    @State private var showNextScreen = false
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
                    
                    Text("GAME OVER")
                    //.font(.system(size:18,weight: .bold))
                        .font(.custom("Inter28pt-SemiBold", size: 35))
                        .foregroundColor(Color.hex484848)
                        .frame(width: 210, height: 46) // 
                    
                  
                  
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
                    timer1.start()
                        
                }
                .onChange(of:  timer1.remainingTime) { newValue in
                    if newValue == 0 {
                                       showNextScreen = true
                        print("Timer reached zero")
                                   }
                }
            
            NavigationLink(destination: flagchallengeScoreview(), isActive: $showNextScreen) {
                                EmptyView()
                            }
                            .hidden()
        } .navigationBarBackButtonHidden(true)
          
    }
}



