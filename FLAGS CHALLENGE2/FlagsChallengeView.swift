import SwiftUI

struct FlagsChallengeView: View {
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var timerValue = 10
    @State private var showNextScreen = false
    @State private var hasTriggered = false
       @State private var currentTime = Date()

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    var body: some View {
        NavigationStack {
            VStack() {
                VStack(spacing:10) {
                    HStack(spacing: 16) {
                        
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.hexFF7043)
                    
                    
                }.padding(.bottom,20)
                
                
                VStack (spacing: 0){
                   // StrokedText(text: "FLAGS CHALLENGE")
                    FlagsHeaderView(title: "FLAGS CHALLENGE", timerValue:10)
                    
                    Divider().padding(.bottom,10)
                    
                    Text("SCHEDULE")
                    //.font(.system(size:18,weight: .bold))
                        .font(.custom("Inter28pt-Bold", size: 18))
                        .foregroundColor(Color.black)
                        .frame(width: 107, height: 22) // Increase height slightly to center better
                   
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1.6)
                        )
                        .multilineTextAlignment(.center)
                    HStack(spacing: 10) {
                        VStack {
                            Text("Hour")
                                .foregroundColor(.black)
                                .font(.custom("Inter28pt-Regular", size: 13))
                            TwoDigitInputView(value: $hours, firstHide: false, isInteractive: true)
                        }
                        
                        VStack {
                            Text("Minute")
                                .foregroundColor(.black)
                                .font(.custom("Inter28pt-Regular", size: 13))
                            TwoDigitInputView(value: $minutes, firstHide: false, isInteractive: true)
                        }
                        
                        VStack {
                            Text("Second")
                                .foregroundColor(.black)
                                .font(.custom("Inter28pt-Regular", size: 13))
                            TwoDigitInputView(value: $seconds, firstHide: false, isInteractive: true)
                        }
                        
                        
                        
                    }
                    .padding(.top,10)
                    .padding(.bottom,20)
                    
                    
                    
                    Button(action: {
                      //  isShowingNextScreen = true
                        let totalSeconds = (hours * 3600) + (minutes * 60) + seconds
                        print("⏱️ Schedule saved: \(hours)h \(minutes)m \(seconds)s = \(totalSeconds) seconds")
                        
                    }
                    ) {
                        Text("Save")
                            .font(.custom("Inter28pt-SemiBold", size: 18))
                            .background(Color.hexFF7043)
                            .frame(width:  107,height: 37.27,alignment: .center)
                        
                            .foregroundColor(.white)
                            .cornerRadius(4)
                        
                    }
                    
                    
                    
                    .background(Color.hexFF7043)
                    .frame(width:  107,height: 37.27,alignment: .center)
                    
                    .foregroundColor(.white)
                    .cornerRadius(4)
                    
                    NavigationLink(
                        destination: FlagsChallengeStartingView(),
                        isActive: $showNextScreen
                    ) { EmptyView() }
                    
                      
                    Spacer()
                }
                
                
                .frame(width: UIScreen.main.bounds.width - 10, height: 281)
                
                .background(Color.hexD9D9D9) // ✅ only this one
                .cornerRadius(2)
                .shadow(radius: 1)
                .offset(y: -20)
                
                
                Spacer()
                
            }
            
            Spacer()
                .onAppear {
                 
                }
        }
        .onReceive(timer) { time in
        
           currentTime = time

              if !hasTriggered && is20SecondsBeforeAlarm(now: time) {
                  print(" Time start")
                  hasTriggered = true
                  showNextScreen = true
              }else{
                  print(" Time not start")
              }
          }
    }
    
    
  


    func formattedAlarmTime() -> String {
          let alarmDate = createAlarmDate()
          let formatter = DateFormatter()
          formatter.timeStyle = .medium
          return formatter.string(from: alarmDate)
      }

      func formattedTime(date: Date) -> String {
          let formatter = DateFormatter()
          formatter.timeStyle = .medium
          return formatter.string(from: date)
      }

      func createAlarmDate() -> Date {
          let calendar = Calendar.current
          var components = calendar.dateComponents([.year, .month, .day], from: Date())
          components.hour = hours
          components.minute = minutes
          components.second = seconds
          print("hours\(hours).minutes\(minutes).seconds\(seconds).")
         
          let now = Date()

          let componentst = calendar.dateComponents([.hour, .minute, .second], from: now)

          if let hour = componentst.hour,
             let minute = componentst.minute,
             let second = componentst.second {

              let formatted = "hours\(hour).minutes\(minute).seconds\(second)"
              print(formatted)
          }
          
          return calendar.date(from: components) ?? Date()
      }

      func is20SecondsBeforeAlarm(now: Date) -> Bool {
          let alarmDate = createAlarmDate()
          let targetTriggerTime = alarmDate.addingTimeInterval(-20)
          return Calendar.current.isDate(now, equalTo: targetTriggerTime, toGranularity: .second)
      }
}






