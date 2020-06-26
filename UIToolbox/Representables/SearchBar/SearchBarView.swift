//
//  SearchBarView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 25/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

public struct SearchBarView: UIViewRepresentable {
    @Binding var text: String
    @Binding var placeholder: String
    @Environment(\.colorScheme) var colorScheme
    @Binding var isOnFocus: Bool
    var textfieldChangedHandler: ((String) -> Void)?
    var onCommitHandler: (() -> Void)?
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, isOnFocus: $isOnFocus, textfieldChangedHandler: textfieldChangedHandler)
    }
    public func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UITextField {
        let searchBar = UITextField(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        searchBar.inputAccessoryView?.isUserInteractionEnabled = true
        searchBar.autocorrectionType = .no
        searchBar.isAccessibilityElement = true
        searchBar.returnKeyType = .done
        searchBar.accessibilityTraits = .searchField
        searchBar.accessibilityLabel = placeholder
        searchBar.accessibilityValue = text
        return searchBar
    }

    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = text
        uiView.textColor = (self.colorScheme == .dark) ? UIColor.white : UIColor.label
        uiView.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                          attributes: [NSAttributedString.Key.foregroundColor
                                                            : UIColor.systemGray])
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var isOnFocus: Bool
        var textfieldChangedHandler: ((String) -> Void)?
        var onCommitHandler: (() -> Void)?
        
        public init(text: Binding<String>, isOnFocus: Binding<Bool>, textfieldChangedHandler: ((String) -> Void)?) {
            _text = text
            _isOnFocus = isOnFocus
            self.textfieldChangedHandler = textfieldChangedHandler
        }
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                SearchBarView(text: .constant(""),
                              placeholder: .constant("Search for all"),
                              isOnFocus: .constant(false),
                              textfieldChangedHandler: { text in
                                
                }, onCommitHandler: {
                    
                }).padding()
            }
            .clipped()
            .background(Color.white)
            .cornerRadius(10)
            .frame(width: 350, height: 40)
            .padding()
            .previewLayout(.sizeThatFits)
            .shadow(radius: 2)
            .environment(\.colorScheme, .dark)
            
            HStack {
                SearchBarView(text: .constant(""),
                              placeholder: .constant("Search for all"),
                              isOnFocus: .constant(false),
                              textfieldChangedHandler: { text in
                                
                }, onCommitHandler: {
                    
                }).padding()
            }
            .clipped()
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(10)
            .frame(width: 350, height: 40)
            .padding()
            .previewLayout(.sizeThatFits)
            .shadow(radius: 2)
            .environment(\.colorScheme, .dark)
        }
    }
}
