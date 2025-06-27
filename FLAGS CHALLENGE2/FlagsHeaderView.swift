//
//  headerview.swift
//  FLAGS CHALLENGE2
//
//  Created by Bijeesh on 26/06/25.
//

import Foundation
import SwiftUI


struct FlagsHeaderView: View {
    var title: String = ""
    var timerValue: Int

    var body: some View {
        ZStack {
            // Centered Title with Stroke & Shadow
            StrokedText(text: title)
                .font(.custom("Inter28pt-SemiBold", size: 18))
                .foregroundColor(Color.hexFF7043)
                .frame(maxWidth: .infinity, alignment: .center)
                .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 2)

            HStack {
                ZStack {
                    // Gradient timer background
                    RadialGradient(
                        gradient: Gradient(colors: [
                            .black.opacity(0.65),
                            .black
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 50
                    )

                    // Timer text
                    Text("00:\(String(format: "%02d", timerValue))")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(width: 90, height: 61.29)
                .clipShape(CustomCorner(radius: 8, corners: [.topLeft, .topRight, .bottomRight]))

                Spacer()
            }
        }
        .frame(height: 61.29)
    }
}


struct StrokedText: View {
    var text: String
    var fontSize: CGFloat = 18
    var strokeColor: Color = .black
    var strokeWidth: CGFloat = 1
    var fillColor: Color = Color.hexFF7043// Orange

    var body: some View {
        ZStack {
            // Simulate stroke by drawing multiple shadows
            Text(text)
                .font(.custom("Inter28pt-Bold", size: fontSize))
                .foregroundColor(strokeColor)
                .shadow(color: strokeColor, radius: 0, x:  strokeWidth, y: 0)
                .shadow(color: strokeColor, radius: 0, x: -strokeWidth, y: 0)
                .shadow(color: strokeColor, radius: 0, x: 0, y: strokeWidth)
                .shadow(color: strokeColor, radius: 0, x: 0, y: -strokeWidth)

            // Fill text
            Text(text)
                .font(.custom("Inter28pt-Bold", size: fontSize))
                .foregroundColor(fillColor)
        }
    }
}



struct FlagsHeaderViewWithout: View {
    var title: String = ""
    var timerValue: Int
    var fillColor: Color = Color.hexFF7043// Orange
    var body: some View {
        ZStack {
          
            Text(title)
              
                .foregroundColor(fillColor)
                .font(.custom("Inter28pt-SemiBold", size: 18))
                .foregroundColor(Color.hexFF7043)
                .frame(maxWidth: .infinity, alignment: .center)
               // .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 2)

            HStack {
                ZStack {
                    // Gradient timer background
                    RadialGradient(
                        gradient: Gradient(colors: [
                            .black.opacity(0.65),
                            .black
                        ]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 50
                    )

                    // Timer text
                    Text("00:\(String(format: "%02d", timerValue))")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(width: 90, height: 61.29)
                .clipShape(CustomCorner(radius: 8, corners: [.topLeft, .topRight, .bottomRight]))

                Spacer()
            }
        }
        .frame(height: 61.29)
    }
}
