//
//  SearchBarSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct SearchBarSampleView: View {
    @State private var text: String = ""
    @State private var isOnFocus: Bool = false
    var items: [String] = ["Red", "Yellow", "Green", "Black", "White", "Orange", "Blue", "Grey"]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass").padding(.leading, 20)
                SearchBarView(text: self.$text,
                              placeholder: .constant("Search for all"),
                              isOnFocus: self.$isOnFocus,
                              textfieldChangedHandler: { text in
                                
                }, onCommitHandler: {
                    
                })
            }
            .clipped()
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(10)
            .frame(width: 350, height: 40)
            .padding(.top, 10)
            .shadow(radius: 2)
            List(items.filter {
                if self.text.count == 0 {
                    return true
                }
                return $0.lowercased().contains(self.text)
            }, id: \.self) { item in
                Text(item).padding()
            }
        }
    }
}

//struct SearchBarSampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarSampleView()
//    }
//}
