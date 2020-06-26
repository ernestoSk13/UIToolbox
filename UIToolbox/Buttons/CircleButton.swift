//
//  CircleButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

public struct CircleButton: View {
    var circleColor: Color
    var fontColor: Color
    var shadowRadius: CGFloat
    var title: String
    var action: (() -> ())
    
    public init(title: String,
                color: Color = .blue,
                fontColor: Color = .white,
                shadowRadius: CGFloat = 0,
                action: @escaping (() -> ())) {
        self.circleColor = color
        self.fontColor = fontColor
        self.title = title
        self.shadowRadius = shadowRadius
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            
        }, label: {
            ZStack {
                Circle()
                Text(self.title).foregroundColor(fontColor)
            }
        }).shadow(radius: shadowRadius).foregroundColor(circleColor)
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
        }
    }
}
