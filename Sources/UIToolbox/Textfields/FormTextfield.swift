//
//  FormTextfield.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

public enum DataType: String, CaseIterable, Hashable, Codable {
    case text = "text"
    case url = "url"
    case number = "number"
    case email = "email"
}

#if targetEnvironment(macCatalyst) || os(iOS)
public struct FormTextfield: View {
    @Binding var text: String
    var placeholder: String
    var textfieldTitle: String
    var dataType: DataType?
    var infoText: String
    var onCommit: (() -> ())?
    var keyboardType: UIKeyboardType = .default
    var showInfo: Bool = false
    var infoActions: (() -> ())?
    
    public init(text: Binding<String>,
                placeholder: String,
                textfieldTitle: String,
                dataType: DataType = .text,
                showInfo: Bool = false,
                infoText: String = "",
                keyboardType: UIKeyboardType = .default,
                onCommit: (() -> ())?,
                infoActions: (() -> ())?) {
        _text = text
        self.placeholder = placeholder
        self.textfieldTitle = textfieldTitle
        self.dataType = dataType
        self.showInfo = showInfo
        self.infoText = infoText
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
                              infoText: "Ayuda",
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
                              infoText: "Ayuda",
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
