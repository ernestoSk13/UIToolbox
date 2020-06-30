//
//  PasswordField.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// A custom Password textfield that can show/hide the typed password.
public struct PasswordField: View {
    @Binding var text: String
    var placeholder: String
    var showable: Bool
    @State private var showPassword: Bool = false
    
    /// Creates an instance
    /// - Parameters:
    ///   - text: The text that will be display and edited.
    ///   - placeholder: The place holder that will appear in the current text field
    ///   - showable: Determines if the "show password" button is going to appear.
    public init(text: Binding<String>,
         placeholder: String,
         showable: Bool = false) {
        _text = text
        self.placeholder = placeholder
        self.showable = showable
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
            HStack {
                if self.showPassword {
                    TextField(placeholder, text: self.$text)
                } else {
                    SecureField(placeholder, text: self.$text)
                }
                if self.showable {
                    Button(action: {
                        self.showPassword.toggle()
                    }, label: {
                        if self.showPassword {
                            Image(systemName: "eye.slash")
                        } else {
                            Image(systemName: "eye")
                        }
                    }).foregroundColor(Color.primary)
                }
            }.padding()
        }
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PasswordField(text: .constant("1234567890"),
                          placeholder: "Password", showable: true)
            .frame(width: 300, height: 50)
            .padding()
            .previewLayout(.sizeThatFits)
            .clipped()
            .shadow(radius: 2)
            
            PasswordField(text: .constant(""), placeholder: "Password")
            .frame(width: 300, height: 50)
            .padding()
            .previewLayout(.sizeThatFits)
            .environment(\.colorScheme, .dark)
            .clipped()
            .shadow(radius: 2)
        }
    }
}
#endif
