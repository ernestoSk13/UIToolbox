//
//  TextViewRepresentable.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if !os(macOS)
import UIKit

public struct TextViewRepresentable: UIViewRepresentable {
    public typealias UIViewType = UITextView
    @Binding var text: String
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    var textColor = UIColor.label
    var background = UIColor.systemBackground
    var isEditable = true
    var attributedString: NSAttributedString?
    
    public init(text: Binding<String>,
                font: UIFont = UIFont.systemFont(ofSize: 12),
                textColor: UIColor = UIColor.label,
                background: UIColor = UIColor.systemBackground,
                isEditable: Bool = true,
                attributedString: NSAttributedString? = nil) {
        _text = text
        self.font = font
        self.textColor = textColor
        self.background = background
        self.isEditable = isEditable
        self.attributedString = attributedString
    }
    
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView(frame: .zero)
        DispatchQueue.main.async {
            if let attributedText = self.attributedString {
                textView.attributedText = attributedText
            } else {
                textView.text = self.text
            }
            textView.textColor = self.textColor
            textView.backgroundColor = self.background
            textView.font = self.font
            textView.isEditable = self.isEditable
        }
        return textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textColor = textColor
    }
}

struct TextViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextViewRepresentable(text: .constant("Lorem Ipsum"))
            .padding()
            .cornerRadius(2)
            .clipped()
            .shadow(radius: 2)
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .light)
        }
    }
}
#endif
