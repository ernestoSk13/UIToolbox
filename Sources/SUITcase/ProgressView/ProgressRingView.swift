//
//  ProgressRingView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 07/07/20.
//

import SwiftUI

public struct ProgressRingView: View {
    @Binding var progress: CGFloat
    var progressColor: Color = .blue
    
    public init(progress: Binding<CGFloat>, progressColor: Color = .blue) {
        _progress = progress
        self.progressColor = progressColor
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 10)
            Circle()
            .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [Color.blue]),
                                    center: .center,
                                    startAngle:  .degrees(0),
                                    endAngle: .degrees(25)
                    ), style: StrokeStyle(lineWidth: 10, lineCap: .round)
            ).rotationEffect(.degrees(-90))
        }.frame(width: 100, height: 100)
    }
}

struct CenteredLabel: ViewModifier {
    var progress: CGFloat
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Text("\(Int(progress * 100)) %")
            .bold()
            .transition(.opacity)
            .padding()
        }
    }
}

public extension ProgressRingView {    
    func showProgress(label: CGFloat) -> some View {
        self.modifier(PercentageIndicator(progress: label))
    }
}

struct PercentageIndicator: AnimatableModifier {
    var progress: CGFloat = 0
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        content.overlay(CenteredProgress(progress: progress))
    }
}

struct CenteredProgress: View {
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            Text("\(Int(progress * 100)) %")
            .bold()
            .transition(.opacity)
            .padding()
        }
    }
}

public struct UndeterminedProgressRingView: View {
    @State private var progress: CGFloat = 0.25
    @State private var degrees: Double = 0
    var progressColor: Color = .blue
    
    @State private var animate = false
    
    public init(progressColor: Color = .blue) {
        self.progressColor = progressColor
    }
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 10)
            Circle()
                .trim(from: self.animate ? 0 : 1, to: self.animate ? 0.25 : 1)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [Color.blue]),
                                    center: .center,
                                    startAngle:  .degrees(0),
                                    endAngle: .degrees(25)
                    ), style: StrokeStyle(lineWidth: 10, lineCap: .round)
            ).rotationEffect(.degrees(self.degrees)).opacity(self.animate ? 1.0 : 0)
                .animation(Animation.linear(duration: 1).repeatForever().delay(0.1))
        }.frame(width: 100, height: 100)
            .onAppear {
                self.animate.toggle()
        }
    }
    
    var reapeatingAnimation: Animation {
        Animation.linear(duration: 0.3).repeatForever()
    }
}


struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRingView(progress: .constant(0.25))
                .showProgress(label: 25)
            .previewLayout(.sizeThatFits)
            .padding()
            .environment(\.colorScheme, .light)
            
            
            UndeterminedProgressRingView()
            .previewLayout(.sizeThatFits)
            .padding()
            .environment(\.colorScheme, .light)
            
        }
    }
}
