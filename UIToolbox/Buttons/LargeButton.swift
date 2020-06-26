//
//  LargeButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

public struct LargeButton: View {
    var title: String
    var action: (() -> ())
    var frame: (width: CGFloat?, height: CGFloat?)
    var color: Color
    var fontColor: Color
    
    public init(title: String,
                frame: (width: CGFloat?, height: CGFloat?) = (width: 200, height: 50),
                color: Color = .blue, fontColor: Color = .white,
                action: @escaping (() -> ())) {
        self.title = title
        self.action = action
        self.frame = frame
        self.color = color
        self.fontColor = fontColor
    }
    
    public var body: some View {
        Button(action: {
            self.action()
        }, label: {
             Text(title)
        }).frame(width: frame.width, height: frame.height)
        .background(color)
        .foregroundColor(fontColor)
        .cornerRadius(10)
    }
}

struct LargeButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LargeButton(title: "Hello",
                        action: {
                
                }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Default")
            LargeButton(title: "Hello",
                        color: Color.red,
                        action: {
                
                }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Custom Color")
            LargeButton(title: "Hello",
                        color: Color.green,
                        action: {
                            
            }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Custom Color")
        }
    }
}
