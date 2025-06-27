//
//  nextview.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 25/06/25.
//
import SwiftUI
import Foundation


struct FlagsChallengeStartingView: View {
    @StateObject var timer1 = CommonTimer(duration: 20) {
           print("Timer complete1!")
       }

    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var timerValue = 10
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
                    FlagsHeaderView(title: "FLAGS CHALLENGE", timerValue:10)
                    
                    Divider().padding(.bottom,10)
                    
                    Text("CHALLENGE")
                    //.font(.system(size:18,weight: .bold))
                        .font(.custom("Inter28pt-SemiBold", size: 18))
                        .foregroundColor(Color.black)
                        .frame(width: 109, height: 22) // Increase height slightly to center better
                    
                    Text("WILL START IN")
                    //.font(.system(size:18,weight: .bold))
                        .font(.custom("Inter28pt-SemiBold", size: 24))
                        .foregroundColor(Color.black)
                        .frame(width: 173, height: 32) // Increase height slightly to center better
                        .padding(.top,10)
                    TimerDisplayView(timerValue: timer1.remainingTime)
                    Spacer()
                }
                
                
                .frame(width: UIScreen.main.bounds.width - 10, height: 215)
                
                .background(Color.hexD9D9D9) //
                .cornerRadius(2)
                .shadow(radius: 1)
                .offset(y: -20)
                
                
                Spacer()
                
            }
           
                .onAppear {
                    // Initialize with padded format
                    for family in UIFont.familyNames {
                        print("Family: \(family)")
                        for name in UIFont.fontNames(forFamilyName: family) {
                            print("   \(name)")
                        }
                    }
                }
            
            NavigationLink(destination: FlagsChallengeQuestionView(), isActive: $showNextScreen) {
                                EmptyView()
                            }
                            .hidden()
        } .navigationBarBackButtonHidden(true)
            .onAppear(){
                timer1.start()
            }
            .onChange(of:  timer1.remainingTime) { newValue in
                if newValue == 0 {
                                   showNextScreen = true
                    print("Timer reached zero")
                               }
            }
    }
}





