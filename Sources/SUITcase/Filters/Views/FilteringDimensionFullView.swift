//
//  FilteringDimensionFullView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 13/01/21.
//

import SwiftUI

public struct FilteringDimensionFullView: View {
    var title: String
    @State var elements: [String]
    @Binding var selectedIndexes: [Int]
    var fontName: String?
    var primaryColor: Color = Color.primary
    @State var showSearchField = false
    @State var searchText: String = ""
    var textfieldPlaceholder: String
    var cancelTitle: String
    @Binding var textFieldFocused: Bool
    
    public init(title: String,
                elements: [String],
                selectedIndexes: Binding<[Int]>,
                fontName: String? = nil,
                primaryColor: Color = Color.primary,
                textfieldPlaceholder: String = "",
                cancelTitle: String = "Cancel",
                textFieldFocused: Binding<Bool>) {
        self.title = title
        _elements = State(initialValue: elements)
        _selectedIndexes = selectedIndexes
        _textFieldFocused = textFieldFocused
        self.fontName = fontName
        self.textfieldPlaceholder = textfieldPlaceholder
        self.primaryColor = primaryColor
        self.cancelTitle = cancelTitle
    }
    
    
    public var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if !showSearchField {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.showSearchField.toggle()
                        }
                    }, label: {
                        HStack {
                            Text(title)
                                .bold()
                                .body(font: fontName)
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                        }
                    })
                    .foregroundColor(primaryColor)
                } else {
                    InputSearchBar(text: $searchText,
                                   placeholder: textfieldPlaceholder,
                                   elements: elements,
                                   selected: $selectedIndexes,
                                   isOnFocus: .constant(true))
                        .frame(height: 30)
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.showSearchField.toggle()
                        }
                    }, label: {
                        Text(cancelTitle)
                    }).foregroundColor(primaryColor)
                }
            }.padding()
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack {
                    ForEach(selectedIndexes, id: \.self) { elementIdx in
                        HStack {
                            Text(elements[elementIdx])
                                .body(font: fontName)
                            Image(systemName: "xmark")
                        }.frame(height: 20)
                        .contentShape(Rectangle())
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .foregroundColor(primaryColor)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(primaryColor, lineWidth: 2))
                        .onTapGesture {
                            self.selectedIndexes.removeAll(where: { $0 == elementIdx})
                        }
                    }
                }.padding()
            })
        }
    }
}

struct FilteringDimensionFullView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringDimensionFullView(title: "Brand",
                                   elements: ["Sony", "Apple", "HP", "Lenovo"],
                                   selectedIndexes: .constant([0, 2]),
                                   textFieldFocused: .constant(false))
    }
}
