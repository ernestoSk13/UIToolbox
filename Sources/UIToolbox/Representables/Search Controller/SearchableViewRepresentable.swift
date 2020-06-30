//
//  SearchableViewRepresentable.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 30/06/20.
//

import SwiftUI
import Combine

public extension View {
    func navigationBarSearch(_ searchText: Binding<String>) -> some View {
        return overlay(SearchableViewRepresentable(text: searchText).frame(width: 0, height: 0))
    }
}

struct SearchableViewRepresentable: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }
    
    typealias UIViewControllerType = SearchBarWrapper
    @Binding var text: String
        
    init(text: Binding<String>) {
        _text = text
    }
    
    func makeUIViewController(context: Context) -> SearchBarWrapper {
        return SearchBarWrapper()
    }
    
    func updateUIViewController(_ uiViewController: SearchBarWrapper, context: Context) {
        
    }
    
    class Coordinator: NSObject, UISearchResultsUpdating {
        @Binding var text: String
        let searchController: UISearchController
        
        private var subscription: AnyCancellable?
        
        init(text: Binding<String>) {
            _text = text
            self.searchController = UISearchController(searchResultsController: nil)
            super.init()
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = true
            searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.text = self.text
            self.subscription = self.text.publisher.sink { _ in
                self.searchController.searchBar.text = self.text
            }
        }
        
        deinit {
            self.subscription?.cancel()
        }
        
        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text else { return }
            self.text = text
        }
    }
    
    class SearchBarWrapper: UIViewController {
        var searchController: UISearchController? {
            didSet {
                self.parent?.navigationItem.searchController = searchController
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            self.parent?.navigationItem.searchController = searchController
        }
        
        override func viewDidAppear(_ animated: Bool) {
            self.parent?.navigationItem.searchController = searchController
        }
    }
}

struct SearchableViewRepresentable_Previews: PreviewProvider {
    @State static var searchText: String = ""
    static var previews: some View {
        NavigationView {
            List(listSampleData.filter {
                if $0.count == 0 { return true }
               return  $0.contains(self.searchText)
            }, id: \.self) { item in
                Text(item).padding()
            }.navigationBarSearch(self.$searchText)
        }
    }
}
