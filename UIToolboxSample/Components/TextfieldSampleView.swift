//
//  TextfieldSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

enum TextfieldTypes: String, CaseIterable {
    case simple = "Simple"
    case infoField = "Info Field"
    case password = "Password Field"
    case passwordShowable = "Showable Password Field"
}

struct TextfieldSampleView: View {
    @State private var types: TextfieldTypes = .simple
    @State private var currentText: String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                Picker(selection: self.$types, label: Text("")) {
                    ForEach(TextfieldTypes.allCases, id: \.self) {  type in
                        Text("\(type.rawValue)")
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 20)
                currentTextField.padding(.horizontal, 10)
            }
        }
    }
    
    var currentTextField: AnyView {
        switch self.types {
        case .simple:
            return AnyView(HStack {
                FormTextfield(text: self.$currentText,
                              placeholder: "Write Something",
                              textfieldTitle: "Username",
                              dataType: .text,
                              showInfo: false,
                              infoText: "",
                              keyboardType: .default,
                              onCommit: nil, infoActions: nil)
            }.padding())
        case .infoField:
            return AnyView(
                HStack(spacing: 30) {
                    FormTextfield(text: self.$currentText,
                                  placeholder: "Write Something",
                                  textfieldTitle: "Username",
                                  dataType: .text,
                                  showInfo: true,
                                  infoText: "info",
                                  keyboardType: .default,
                                  onCommit: nil, infoActions: nil)
                }.padding()
            )
        case .password:
            return AnyView(
                HStack(spacing: 30) {
                    PasswordField(text: self.$currentText, placeholder: "Enter password")
                    .clipped()
                    .shadow(radius: 2)
                }.padding()
            )
        case .passwordShowable:
            return AnyView(
                HStack(spacing: 30) {
                    PasswordField(text: self.$currentText, placeholder: "Enter password", showable: true)
                    .clipped()
                    .shadow(radius: 2)
                }.padding()
            )
        }
    }
}

struct PasswordSectionView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Password Field").bold()
                Spacer()
            }.padding()
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 30) {
                    PasswordField(text: .constant(""), placeholder: "Enter password")
                    .frame(width: 300, height: nil)
                    .clipped()
                    .shadow(radius: 2)
                }.padding()
            }
            Divider()
            HStack {
                Text("Showable Password Field").bold()
                Spacer()
            }.padding()
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 30) {
                    PasswordField(text: .constant(""), placeholder: "Enter password", showable: true)
                    .frame(width: 300, height: nil)
                    .clipped()
                    .shadow(radius: 2)
                }.padding()
            }
        }
    }
}


//struct Textfield_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            TextfieldSampleView()
//        }
//    }
//}
