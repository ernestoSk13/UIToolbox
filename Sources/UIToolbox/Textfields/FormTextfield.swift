//
//  FormTextfield.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

/// An enum that represents the type of data that can be used in a textfield
public enum DataType: String, CaseIterable, Hashable, Codable {
    case text = "text"
    case url = "url"
    case number = "number"
    case email = "email"
}

#if targetEnvironment(macCatalyst) || os(iOS)
/// A textfiled that can be used in forms or other formularies.
public struct FormTextfield: View {
    @Binding var text: String
    var placeholder: String
    var textfieldTitle: String
    var dataType: DataType?
    var onCommit: (() -> ())?
    var keyboardType: UIKeyboardType = .default
    var showInfo: Bool = false
    var infoActions: (() -> ())?
    
    /// Creates an instance
    /// - Parameters:
    ///   - text: The text to be displayed and edited.
    ///   - placeholder: The placeholder to be displayed and edited.
    ///   - textfieldTitle: The title that will be shown at the top of the current text field.
    ///   - dataType: A `DataType` enum indicating the data expected in the textfield.
    ///   - showInfo: Determines if an info button should be displayed to the right of the text field's title.
    ///   - keyboardType: The type of keyboard to display for a given text-based view.
    ///   - onCommit:  a block that is executed when the user taps on the `Done` key.
    ///   - infoActions: a block that will be executed when the info button is tapped.
    public init(text: Binding<String>,
                placeholder: String,
                textfieldTitle: String,
                dataType: DataType = .text,
                showInfo: Bool = false,
                keyboardType: UIKeyboardType = .default,
                onCommit: (() -> ())?,
                infoActions: (() -> ())?) {
        _text = text
        self.placeholder = placeholder
        self.textfieldTitle = textfieldTitle
        self.dataType = dataType
        self.showInfo = showInfo
        self.keyboardType = keyboardType
        self.onCommit = onCommit
        self.infoActions = infoActions
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(textfieldTitle).font(.callout).foregroundColor(Color.primary)
                if showInfo {
                    Button(action: {
                        self.infoActions?()
                    }, label: {
                        Image(systemName: "info.circle")
                    }).foregroundColor(Color.primary).padding(.leading, 20)
                }
                Spacer()
            }
            VStack {
                TextField(self.placeholder, text: self.$text, onCommit: {
                    self.onCommit?()
                })
                    .font(.callout)
                    .padding()
                    .textContentType(.oneTimeCode)
                    .disableAutocorrection(true)
                    .keyboardType(self.dataType != nil ? (self.dataType == .number ? .numbersAndPunctuation : .default) : keyboardType)
                    .autocapitalization(.none)
                    .textFieldStyle(DefaultTextFieldStyle())
                }
            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1))
            .background(Color(UIColor.tertiarySystemBackground))
        }
    }
}

struct FormTextfield_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                FormTextfield(text: .constant(""),
                              placeholder: "Teléfono",
                              textfieldTitle: "Teléfono",
                              dataType: .number,
                              showInfo: true,
                               keyboardType: .numberPad,
                              onCommit: {
                                
                }, infoActions: {
                    
                }).padding()
            }.previewLayout(.sizeThatFits)
            HStack {
                FormTextfield(text: .constant(""),
                              placeholder: "Teléfono",
                              textfieldTitle: "Teléfono",
                              dataType: .number,
                              keyboardType: .numberPad,
                              onCommit: {
                                
                }, infoActions: {
                    
                }).padding()
            }.previewLayout(.sizeThatFits)
                .background(Color.black)
            .environment(\.colorScheme, .dark)
        }
    }
}
#endif
