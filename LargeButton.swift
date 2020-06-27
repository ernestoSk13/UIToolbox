//
//  LargeButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

public enum ButtonStyle {
    case bordered
    case filled
}

public struct LargeButton: View {
    var title: String
    var symbolName: String?
    var action: (() -> ())
    var frame: (width: CGFloat?, height: CGFloat?)
    var color: Color
    var fontColor: Color
    var style: ButtonStyle
    
    public init(title: String,
                symbolName: String? = nil,
                frame: (width: CGFloat?, height: CGFloat?) = (width: nil, height: 50),
                color: Color = .blue, fontColor: Color = .white,
                style: ButtonStyle = .filled,
                action: @escaping (() -> ())) {
        self.title = title
        self.symbolName = symbolName
        self.action = action
        self.frame = frame
        self.color = color
        if fontColor.hashValue != color.hashValue {
            self.fontColor = fontColor
        } else {
            self.fontColor = color
        }
        self.style = style
    }
    
    public var body: some View {
        Button(action: {
            self.action()
        }, label: {
            ZStack {
               RoundedRectangle(cornerRadius: 12).stroke(Color.clear)
                HStack {
                    if self.symbolName != nil {
                        Image(systemName: self.symbolName!).padding(.leading, 20)
                    }
                    Text(title).padding(.horizontal, self.symbolName != nil ? 5 : 0)
                    if self.symbolName != nil {
                        Spacer()
                    }
                }.padding(.horizontal, 5)
            }
        }).frame(width: frame.width, height: frame.height)
        .background(self.style == .filled ? color : .clear)
            .foregroundColor(self.style == .bordered ? color : fontColor)
        .cornerRadius(self.style == .bordered ? 0 : 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 1).padding(.all, 1)
                
            )
        .clipped()
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
            LargeButton(title: "Hello",
                        color: Color.blue,
                        style: .bordered,
                        action: {
                            
            }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Bordered")
            LargeButton(title: "Hello",
                        symbolName: "person",
                        color: Color.blue,
                        style: .bordered,
                        action: {
                            
            }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Bordered")
        }
    }
}
