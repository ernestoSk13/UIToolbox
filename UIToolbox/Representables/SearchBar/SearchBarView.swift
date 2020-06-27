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
    
    public init(text: Binding<String>,
         placeholder: Binding<String>,
         isOnFocus: Binding<Bool>,
         textfieldChangedHandler: ((String) -> Void)? = nil,
         onCommitHandler: (() -> Void)? = nil) {
        _text = text
        _placeholder = placeholder
        _isOnFocus = isOnFocus
        self.textfieldChangedHandler = textfieldChangedHandler
        self.onCommitHandler = onCommitHandler
    }
    
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
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            isOnFocus = true
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            isOnFocus = false
            textField.resignFirstResponder()
            return true
        }

        public func textField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool {
            if let currentValue = textField.text as NSString? {
                let proposedValue = currentValue.replacingCharacters(in: range, with: string)
                textfieldChangedHandler?(proposedValue as String)
                DispatchQueue.init(label: "textfield", qos: .userInteractive).async {
                    self.text = proposedValue
                }
            }
            return true
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            isOnFocus = false
            onCommitHandler?()
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
