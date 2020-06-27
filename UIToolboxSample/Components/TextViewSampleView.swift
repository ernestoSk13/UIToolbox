//
//  TextViewSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct TextViewSampleView: View {
    @State private var text: String = ""
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                SectionHeaderView(name: "Simple TextView")
                TextViewRepresentable(text: self.$text)
                    .frame(width: nil, height: 300)
                    .padding()
                    .cornerRadius(2)
                    .clipped()
                    .shadow(radius: 2)
            }
        }
    }
}

//struct TextViewSampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        TextViewSampleView()
//
//    }
//}
