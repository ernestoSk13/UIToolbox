//
//  AutocompleteSearchField.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 15/02/21.
//

import SwiftUI

struct AutocompleteSearchField: UIViewRepresentable {
    @Binding var text: String
    @Binding var realText: String
    @Binding var startedEditing: Bool
    var placeholder: String
    var elements: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchTextField.font = UIFont(name: "OracleSans-Regular", size: 17)
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.borderColor = UIColor.textfieldBorder.withAlphaComponent(0.5).cgColor
        searchBar.searchTextField.layer.borderWidth = 1.0
        searchBar.searchTextField.layer.cornerRadius = 4.0
        searchBar.searchTextField.backgroundColor = UIColor.textfieldBackground
        searchBar.searchBarStyle = .prominent
        searchBar.autocapitalizationType = .none
        searchBar.autocorrectionType = .no
        searchBar.isAccessibilityElement = true
        searchBar.returnKeyType = .search
        searchBar.delegate = context.coordinator
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.isTranslucent = true
        searchBar.tintColor = UIColor.label
        return searchBar
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: AutocompleteSearchField
        @Binding var text: String
        var workItem: DispatchWorkItem?
        init(parent: AutocompleteSearchField, text: Binding<String>) {
            self.parent = parent
            _text = text
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            parent.startedEditing = true
            searchBar.showsCancelButton = true
        }
        
        func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return !autoCompleteText(inTextfield: searchBar.searchTextField, using: text, suggestions: parent.elements)
        }
        
        func autoCompleteText(inTextfield textfield: UISearchTextField, using string: String, suggestions: [String]) -> Bool {
            guard string != "\n" else { return false }
            workItem?.cancel()
            
            let workItem = DispatchWorkItem {
                if !string.isEmpty,
                   let selectedTextRange = textfield.selectedTextRange,
                   selectedTextRange.end == textfield.endOfDocument,
                   let prefixRange = textfield.textRange(from: textfield.beginningOfDocument,
                                                         to: selectedTextRange.start),
                   let text = textfield.text(in: prefixRange) {
                    let prefix = text //+ string
                    self.text = prefix
                    let matches = suggestions.filter { $0.lowercased().hasPrefix(prefix.lowercased()) }
                    if matches.count > 0 {
                        if let currentText = matches.first {
                            let markedText = String(currentText.dropFirst(prefix.count))
                            textfield.setMarkedText(markedText, selectedRange: NSRange())
                            return
                        }
                    }
                } else {
                    if string.isEmpty {
                        if let currentText = textfield.text, !currentText.isEmpty {
                            self.text = currentText
                        }
                    } else {
                        self.text = (textfield.text ?? "") + string
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: workItem)
            self.workItem = workItem
            return false
        }
        
        func colourSuggestedSubstring(textfield: UISearchTextField, from start: UITextPosition, to end: UITextPosition) {
            guard let currentText = textfield.text else { return  }
            let startPosition = textfield.offset(from: textfield.beginningOfDocument, to: start)
            let endPosition = textfield.offset(from: textfield.beginningOfDocument, to: end)
            
            let coloredString = NSMutableAttributedString(string: currentText)
            coloredString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray,
                                       range: NSRange(location: startPosition, length: endPosition - startPosition))
            textfield.attributedText = coloredString
        }
        
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                self.text = searchText
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            parent.startedEditing = false
            parent.text = ""
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.text = searchBar.searchTextField.text ?? ""
            parent.startedEditing = false
            searchBar.resignFirstResponder()
            searchBar.showsCancelButton = false
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            parent.startedEditing = false
        }
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
}

struct AutocompleteSearchField_Previews: PreviewProvider {
    static var previews: some View {
        AutocompleteSearchField(text: .constant(""),
                                realText: .constant(""),
                                startedEditing: .constant(false),
                                placeholder: "Search", elements: [])
    }
}
