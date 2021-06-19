//
//  ContentView.swift
//  DrawingUI
//
//  Created by Максим Нуждин on 09.05.2021.
//

import SwiftUI

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 50, y: rect.midY + 50))
        path.addLine(to: CGPoint(x: rect.midX + 5, y: rect.midY + 50))
        path.addLine(to: CGPoint(x: rect.midX + 5, y: rect.midY + 200))
        path.addLine(to: CGPoint(x: rect.midX - 5, y: rect.midY + 200))
        path.addLine(to: CGPoint(x: rect.midX - 5, y: rect.midY + 50))
        path.addLine(to: CGPoint(x: rect.midX - 50, y: rect.midY + 50))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        
        return path
    }
}

struct ColorCyrlingRectangle: View {
    var amount: Double
        var steps = 100

        var body: some View {
            ZStack {
                ForEach(0..<steps) { value in
                    Rectangle()
                        .inset(by: CGFloat(value))
                        .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                }
            }
        }

        func color(for value: Int, brightness: Double) -> Color {
            var targetHue = Double(value) / Double(self.steps) + self.amount

            if targetHue > 1 {
                targetHue -= 1
            }

            return Color(hue: targetHue, saturation: 1, brightness: brightness)
        }
    }

struct ContentView: View {
    
    @State private var lineWidth: CGFloat = 1
    @State private var amount: Double = 0.0
    
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation {
                        lineWidth = CGFloat.random(in: 1...25)
                    }
                }
            ColorCyrlingRectangle(amount: amount)
            Slider(value: $amount, in: 0...1)
                .padding([.horizontal, .bottom])
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
