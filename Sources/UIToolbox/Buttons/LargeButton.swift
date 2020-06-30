//
//  LargeButton.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// An enum of button styles
public enum ButtonStyle {
    case bordered
    case filled
}

/// A Large rectangled button with cornered radius.
public struct LargeButton<Label>: View where Label: View {
    var label: Label
    var action: (() -> ())
    var frame: (width: CGFloat?, height: CGFloat?)
    var color: Color
    var fontColor: Color
    var style: ButtonStyle
    
    /// Creates an instance
    /// - Parameters:
    ///   - action: The action to perform when self is triggered.
    ///   - label: A view that describes the effect of calling onTrigger.
    ///   - frame: a tuple that has a width and height parameter. by default the width is dynamic and the height is 50
    ///   - color: The background color (or border color if `style` is .bordered) of the rectangle. It is .blue by default.
    ///   - fontColor: The foreground color that will be given to the `Label` passed. It is .white by default.
    ///   - style:  the `ButtonStyle`  of the button. It is `.bordered` by default.
    public init(action: @escaping (() -> ()),
                @ViewBuilder label: () -> Label,
                frame: (width: CGFloat?, height: CGFloat?) = (width: nil, height: 50),
                color: Color = .blue,
                fontColor: Color = .white,
                style: ButtonStyle = .filled) {
        self.action = action
        self.label = label()
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
               self.label.foregroundColor(self.fontColor)
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
            LargeButton(action: {
                
            }, label: {
                Text("Blue")
            }).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Default")
            LargeButton(action: { }, label: {
                Text("Red")
            }, color: .red)
                .previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Custom Color")
            LargeButton(action: {}, label: {
                Text("Green")
            }, color: .green).previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Custom Color")
            LargeButton(action: {}, label: {
                Text("Bordered")
            }, color: .black, fontColor: .black, style: .bordered)
                .previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Bordered")
            LargeButton(action: { }, label: {
                HStack {
                    Image(systemName: "cart")
                    Text("Buy")
                }
            }) .previewLayout(.sizeThatFits)
                .padding()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Bordered")
        }
    }
}
#endif
