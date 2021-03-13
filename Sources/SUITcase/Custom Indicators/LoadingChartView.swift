//
//  LoadingChartView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 18/08/20.
//

import SwiftUI

struct LoadingChartView: View {
    @State var animateLoaders: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Loader(color: Color.primary.opacity(1.0), loaderState: .down, time: 0.35, startAnimating: self.$animateLoaders)
                Loader(color: Color.primary.opacity(0.75),loaderState: .right, time: 0.35, startAnimating: $animateLoaders)
                Loader(color: Color.primary.opacity(0.5), loaderState: .up, time: 0.35, startAnimating: $animateLoaders)
                Loader(color: Color.primary.opacity(0.25), loaderState: .left, time: 0.35, startAnimating: $animateLoaders)
            }.onAppear {
                self.animateLoaders.toggle()
            }
            Text("Loading").padding()
        }
    }
}

struct LoadingChartView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingChartView()
    }
}

struct Loader: View {
    var color: Color = .blue
    @State var bubbleSize: CGFloat = 24
    @State var xPosition: CGFloat = 0
    @State var yPosition: CGFloat = 0
    @State var loaderState: LoaderState
    @State var currentIndex = 0
    @State var animationStarted = true
    var time: TimeInterval
    @Binding var startAnimating: Bool
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Circle()
                .fill(color)
                .frame(width: bubbleSize, height: bubbleSize, alignment: .center)
                .animation(.easeOut(duration: 0.35))
                .offset(x: self.xPosition, y: self.yPosition)
        }.frame(width: 24, height: 0, alignment: loaderState.alignment)
            .onAppear {
                self.setIndex()
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (initialTimer) in
                    if self.startAnimating {
                        Timer.scheduledTimer(withTimeInterval: self.time, repeats: false) { (separatorTimer) in
                            self.animateBubble()
                            Timer.scheduledTimer(withTimeInterval: 1.1, repeats: true) { (loaderTimer) in
                                if !self.startAnimating {
                                    loaderTimer.invalidate()
                                }
                                self.loaderState = self.getNextCase()
                                self.animateBubble()
                            }
                        }
                        initialTimer.invalidate()
                    }
                }
        }
    }
    
    func getNextCase() -> LoaderState {
        let allCases = LoaderState.allCases
        if self.currentIndex == allCases.count - 1 {
            self.currentIndex = -1
        }
        self.currentIndex += 1
        let index = self.currentIndex
        return allCases[index]
    }
    
    func setIndex() {
        for (idx, loaderCase) in LoaderState.allCases.enumerated() {
            if loaderCase == self.loaderState {
                self.currentIndex = idx
                self.xPosition = LoaderState.allCases[self.currentIndex].previousTransition.0
                self.yPosition = LoaderState.allCases[self.currentIndex].previousTransition.1
            }
        }
    }
    
    func animateBubble() {
        self.xPosition = self.loaderState.previousTransition.0
        self.yPosition = self.loaderState.previousTransition.1
        self.bubbleSize = self.loaderState.previousTransition.2
        
        Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false) { (Timer) in
            self.xPosition = self.loaderState.postTransition.0
            self.yPosition = self.loaderState.postTransition.1
            self.bubbleSize = self.loaderState.postTransition.2
        }
    }
}
