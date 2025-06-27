//
//  ConstantViews.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 27/06/25.
//
import SwiftUI
import Foundation

struct TimerDisplayView: View {
    var timerValue: Int // e.g., 20

    var body: some View {
        Text("00:\(String(format: "%02d", timerValue))")
            .font(.custom("Inter28pt-SemiBold", size: 24))
            .foregroundColor(.gray)
            .frame(width: 90, height: 61.29)
            //.background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.top,8)

    }
}

struct TopLeftBadgeView: View {
    var number: Int =  0

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background container with custom corners
            Color.black.opacity(0.8)
                .frame(width: 43, height: 34)
                .clipShape(CustomCorner(radius: 2, corners: [.topRight, .bottomRight]))

          
            ZStack {
                Circle()
                    .fill(Color.hexFF7043)
                    .frame(width: 29, height: 29)

                Text("\(number)")
                    .font(.custom("Inter28pt-SemiBold", size: 12))
                    .foregroundColor(.white)
            }
            .padding(.leading, 6)  //  X position
            .padding(.top, 3)      // Y position
        }
    }
}

// Reusable Input Box
struct RoundedTextField: View {
    @Binding var intValue: Int
    @State private var text: String = ""

    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .allowsHitTesting(true)
            .multilineTextAlignment(.center)
            .frame(width: 50, height: 40)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .onChange(of: text) { newValue in
                // Allow only numbers and limit to 2 digits
                let filtered = newValue.filter { $0.isNumber }
                if let intVal = Int(filtered.prefix(2)) {
                    intValue = intVal
                    text = String(format: "%02d", intVal)
                } else {
                    intValue = 0
                    text = ""
                }
            }
            .onAppear {
              
                text = String(format: "%02d", intValue)
            }
    }
}

struct TwoDigitInputView: View {
    @Binding var value: Int
    var firstHide: Bool = false
    var isInteractive: Bool = true

    @State private var firstDigit: String = ""
    @State private var secondDigit: String = ""

    var body: some View {
        HStack(spacing: 4) {
            if !firstHide {
                digitField(text: $firstDigit, disabled: !isInteractive)
            }
            digitField(text: $secondDigit, disabled: false)
        }
        .onChange(of: firstDigit) { _ in updateValue() }
        .onChange(of: secondDigit) { _ in updateValue() }
        .onAppear {
            if value > 0 {
                let digits = String(format: "%02d", value).map { String($0) }
                if !firstHide {
                    if digits.count == 2 {
                        firstDigit = digits[0]
                        secondDigit = digits[1]
                    } else {
                        firstDigit = ""
                        secondDigit = digits.first ?? ""
                    }
                } else {
                    firstDigit = ""
                    secondDigit = digits.last ?? ""
                }
            } else {
                // Clear both if value is 0
                firstDigit = ""
                secondDigit = ""
            }
        }
    }

    private func digitField(text: Binding<String>, disabled: Bool) -> some View {
        TextField("0", text: text)
            .keyboardType(.numberPad)
            .frame(width: 55, height: 53)
            .font(.custom("Inter28pt-Bold", size: 28.58))
            .multilineTextAlignment(.center)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(6)
            .disabled(disabled)
            .onChange(of: text.wrappedValue) { newValue in
                let filtered = newValue.filter { $0.isNumber }
                if filtered.count > 1 {
                    text.wrappedValue = String(filtered.prefix(1))
                } else {
                    text.wrappedValue = filtered
                }
            }
    }

    private func updateValue() {
        let combined = (firstHide ? "" : firstDigit) + secondDigit
        value = Int(combined) ?? 0
    }
}


extension Color {
    static let hexFF7043 = Color(red: 1.0, green: 0.44, blue: 0.26) // FF7043
    static let hex484848 = Color(red: 72/255, green: 72/255, blue: 72/255)
    static let hex01C414 = Color(red: 1 / 255, green: 196 / 255, blue: 20 / 255)
    static let hexFF0000 = Color(red: 1.0, green: 0.0, blue: 0.0)
}



extension Color {
    static let hexD9D9D9 = Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
}


struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}



