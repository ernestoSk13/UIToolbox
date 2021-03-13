//
//  UTBProgressView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 27/06/20.
//

import SwiftUI

#if targetEnvironment(macCatalyst) || os(iOS)
public struct SCProgressview: View {
    var backgroundColor: Color
    var progressColor: Color
    @Binding var progress: CGFloat
    var height: CGFloat
    
    public init(progress: Binding<CGFloat>,
                backgroundColor: Color = .gray,
                progressColor: Color = .blue,
                height: CGFloat = 20) {
        _progress = progress
        self.height = height
        self.backgroundColor = backgroundColor
        self.progressColor = progressColor
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(self.backgroundColor)
                HStack {
                    RoundedRectangle(cornerRadius: 12)
                    .fill(self.progressColor)
                    .frame(width: geometry.size.width * self.progress, height: nil, alignment: .leading)
                        .padding(.leading, 0)
                        .opacity(self.progress > 0.1 ? 1.0 : 0.5)
                    Spacer().frame(width: geometry.size.width * (1 - self.progress), height: 20)
                }
            }
        }.frame(width: nil, height: 20)
    }
}


public struct SCUndeterminedProgressView: View {
    var backgroundColor: Color
    var progressColor: Color
    var height: CGFloat
    @Binding var finished: Bool
    @State var position: CGFloat = 0
    @State private var isOnLeft = true
    
    public init(backgroundColor: Color = .gray, progressColor: Color = .blue,
                finished: Binding<Bool>, height: CGFloat = 20) {
        _finished = finished
        self.height = height
        self.backgroundColor = backgroundColor
        self.progressColor = progressColor
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(self.backgroundColor)
                RoundedRectangle(cornerRadius: 12)
                    .fill(self.progressColor)
                    .frame(width: geometry.size.width * 0.5, height: nil, alignment: .leading)
                    .offset(x: self.isOnLeft ? -(geometry.size.width * 0.25) : geometry.size.width * 0.25, y: 0)
                    .padding(.leading, 0)
                    .onAppear() {
                        withAnimation(self.reapeatingAnimation) {
                            self.isOnLeft.toggle()
                        }
                }
            }
        }.frame(width: nil, height: self.height)
    }
    
    var reapeatingAnimation: Animation {
        Animation.linear(duration: 0.5).repeatForever()
    }
}

struct UTBProgressView_Previews: PreviewProvider {
    @State static var progress: CGFloat = 0.7
    
    static var previews: some View {
        Group {
            SCProgressview(progress: self.$progress)
                .previewLayout(.sizeThatFits)
            .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                        withAnimation(.easeInOut) {
                            self.progress += 0.5
                        }
                    })
            }
            
            SCUndeterminedProgressView(finished: .constant(false))
                .previewLayout(.sizeThatFits)
            .padding()
            
            SCUndeterminedProgressView(finished: .constant(false), height: 3)
                .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
#endif
