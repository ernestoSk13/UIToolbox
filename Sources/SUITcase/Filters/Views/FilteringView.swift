//
//  FilteringView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 05/01/21.
//

import SwiftUI

public struct FilteringListView<TopBar>: View where TopBar: View {
    var elements: [String]
    @Binding var selectedIndexes: [Int]
    @Binding var isOpen: Bool
    var maxHeight: CGFloat = 400
    var topBar: TopBar
    var fontName: String?
    var primaryColor: Color = Color.primary
    @State var searchText: String = ""
    @State var startedEditing = false
    
    public init(elements: [String],
                selectedIndexes: Binding<[Int]>,
                isOpen: Binding<Bool>,
                maxHeight: CGFloat = 300,
                @ViewBuilder topBar: () -> TopBar,
                fontName: String? = nil,
                primaryColor: Color = Color.primary) {
        self.elements = elements
        _selectedIndexes = selectedIndexes
        _isOpen = isOpen
        self.maxHeight = maxHeight
        self.topBar = topBar()
        self.fontName = fontName
        self.primaryColor = primaryColor
    }
    
    public var body: some View {
        BottomSheet(isOpen: $isOpen,
                    maxHeight: !startedEditing ? maxHeight : 600,
                    presentedPortion: 0.3, content: {
            HStack {
                topBar
            }.padding()
            .foregroundColor(Color.primary)
            FilteringDimensionView(elements: elements,
                                   selectedIndexes: $selectedIndexes,
                                   searchText: $searchText,
                                   startedEditing: $startedEditing)
        }, draggable: false)
    }
}

struct AutoCompleteResult {
    var title: String
    var realIndex: Int
    var currentIndex: Int
}

public struct FilteringDimensionView: View {
    var elements: [AutoCompleteResult]
    @Binding var selectedIndexes: [Int]
    var fontName: String?
    var primaryColor: Color = Color.primary
    @Binding var searchText: String
    @Binding var startedEditing: Bool
    
    public init(elements: [String],
                selectedIndexes: Binding<[Int]>,
                fontName: String? = nil,
                primaryColor: Color = Color.primary,
                searchText: Binding<String>,
                startedEditing: Binding<Bool>) {
        self.elements = elements.enumerated().map { AutoCompleteResult(title: $0.element,
                                                                       realIndex: $0.offset,
                                                                       currentIndex: $0.offset)}
        _selectedIndexes = selectedIndexes
        _searchText = searchText
        _startedEditing = startedEditing
        self.fontName = fontName
        self.primaryColor = primaryColor
    }
    
    var stringElements: [String] {
        elements.map { $0.title }
    }
    
    public var body: some View {
        VStack {
            AutocompleteSearchField(text: $searchText,
                                    realText: .constant("S"),
                                    startedEditing: $startedEditing,
                                    placeholder: "Search", elements: stringElements.filter { value in
                                        guard !self.searchText.isEmpty else {
                                            return true
                                        }
                                        
                                        return value
                                            .lowercased()
                                            .contains(self.searchText.lowercased())
                                    })
            if filteredElements.count > 0 {
                List {
                    ForEach(Array(filteredElements.enumerated()), id:  \.offset) { (idx, element) in
                        HStack {
                            Text(element.title)
                                .body(font: "OracleSans-Regular")
                            Spacer()
                            if selectedIndexes.contains(element.realIndex) {
                                Image(systemName: "checkmark")
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if !selectedIndexes.contains(element.realIndex) {
                                selectedIndexes.append(element.realIndex)
                            } else {
                                selectedIndexes.removeAll(where: { $0 == element.realIndex})
                            }
                        }
                    }
                }
                .animation(elements.count > 0 ? .default : .none)
                .gesture(DragGesture().onChanged{ _ in
                    withAnimation(.easeInOut(duration: 0.7)) {
                        UIApplication.shared.endEditing()
                    }
                })
            } else {
                Spacer()
                Text("Nothing to see here")
                Spacer()
            }
        }
    }
    
    var filteredElements: [AutoCompleteResult] {
       elements.filter { value in
            guard !self.searchText.isEmpty else {
                return true
            }
            
        return value.title
                .lowercased()
                .contains(self.searchText.lowercased())
        }
    }
        
    
}

struct FilteringView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringListView(elements: ["Sony", "HP", "Mac", "Dell"],
                          selectedIndexes: .constant([1, 3]),
                          isOpen: .constant(true),
                          topBar: {
                            HStack {
                                Button(action: {}, label: {
                                    Text("Back")
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Brand")
                                        .bold()
                                })
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Apply")
                                })
                            }
                          }).background(Color.gray).edgesIgnoringSafeArea(.bottom)
    }
}
