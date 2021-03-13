//
//  SearchControllerSampleView.swift
//  UIToolboxShowcase
//
//  Created by Ernesto Sánchez Kuri on 30/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import SUITcase

struct SearchControllerSampleView: View {
    @State private var text: String = ""
    var items: [String] = ["Red", "Yellow", "Green", "Black", "White", "Orange", "Blue", "Grey"]
    
    var body: some View {
        NavigationView {
            List(items.filter {
                self.text.count == 0 || self.text.contains($0)
            }, id: \.self) { item in
                Text(item).padding()
            }.navigationBarSearch(self.$text)
        }
    }
}

struct SearchControllerSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchControllerSampleView()
    }
}
