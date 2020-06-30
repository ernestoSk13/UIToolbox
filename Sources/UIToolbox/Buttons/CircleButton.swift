//
//  CircleButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// A Button instance with circular form. The Button receives a generic `Label` that can be an image, text, or a combination of both.
public struct CircleButton<Label>: View where Label : View {
    var action: (() -> ())
    var label: Label
    var circleColor: Color
    var fontColor: Color
    var shadowRadius: CGFloat
    var style: ButtonStyle
    
    /// Creates an instance
    /// - Parameters:
    ///   - action: The action to perform when self is triggered.
    ///   - label: A view that describes the effect of calling onTrigger.
    ///   - circleColor: The background color (or border color if `style` is .bordered) of the circle. It is .blue by default.
    ///   - fontColor: The foreground color that will be given to the `Label` passed. It is .white by default.
    ///   - shadowRadius: The shadow radius applied to the circle. It is 0 by default.
    ///   - style: the `ButtonStyle`  of the button. It is `.bordered` by default.
    public init(action: @escaping (() -> ()),
                @ViewBuilder label: () -> Label,
                circleColor: Color = .blue,
                fontColor: Color = .white,
                shadowRadius: CGFloat = 0,
                style: ButtonStyle = .filled) {
        self.circleColor = circleColor
        self.label = label()
        if fontColor.hashValue != circleColor.hashValue {
            self.fontColor = fontColor
        } else {
            self.fontColor = circleColor
        }
        self.shadowRadius = shadowRadius
        self.action = action
        self.style = style
    }
    
    public var body: some View {
        Button(action: {
            self.action()
        }, label: {
            ZStack {
                if self.style == .filled {
                    Circle()
                    .shadow(radius: shadowRadius)
                } else {
                    Circle().stroke()
                    .shadow(radius: shadowRadius)
                }
                self.label.foregroundColor(fontColor)
            }
        }).foregroundColor(circleColor)
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(action: {
                
            }, label: {
                Text("Hello").foregroundColor(Color.white)
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Default Color")
            CircleButton(action: {

            }, label: {
                Text("Red")
            }, circleColor: .red, fontColor: .white)
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Red Color")
            CircleButton( action: {

            }, label: {
                Text("Yellow")
            }, circleColor: .yellow, fontColor: .black, style: .bordered)
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Color and Font")
            
            CircleButton(action: {

            }, label: {
                VStack {
                    Image(systemName: "mic").imageScale(.large)
                    Text("Record").font(.callout)
                }
            }, circleColor: .black)
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Symbol")
        }
    }
}
#endif
