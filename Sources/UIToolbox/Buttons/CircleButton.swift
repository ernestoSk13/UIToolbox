//
//  CircleButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
public struct CircleButton: View {
    var circleColor: Color
    var fontColor: Color
    var shadowRadius: CGFloat
    var title: String
    var symbol: String?
    var action: (() -> ())
    var style: ButtonStyle
    
    public init(title: String,
                symbol: String? = nil,
                color: Color = .blue,
                fontColor: Color = .white,
                shadowRadius: CGFloat = 0,
                style: ButtonStyle = .filled,
                action: @escaping (() -> ())) {
        self.circleColor = color
        if fontColor.hashValue != color.hashValue {
            self.fontColor = fontColor
        } else {
            self.fontColor = color
        }
        self.symbol = symbol
        self.title = title
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
                if self.symbol != nil {
                    Image(systemName: self.symbol!).imageScale(.large).foregroundColor(fontColor)
                } else {
                    Text(self.title).foregroundColor(fontColor)
                }
            }
        }).foregroundColor(circleColor)
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButton(title: "Tap here!", action: {
                
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Default Color")
            CircleButton(title: "Tap here!", color: Color.red, action: {
                
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Red Color")
            CircleButton(title: "Tap here!",
                         color: Color.yellow,
                         fontColor: .black, action: {
                            
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Color and Font")
            CircleButton(title: "Tap here!",
                         color: Color.green,
                         fontColor: .black,
                         style: .bordered,
                         action: {
                            
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Bordered")
            CircleButton(title: "Tap here!",
                         symbol: "mic",
                         color: Color.black,
                         fontColor: .white,
                         style: .filled,
                         action: {
                            
            })
                .previewLayout(.sizeThatFits)
                .padding()
                .frame(width: 100, height: 100)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Symbol")
        }
    }
}
#endif
