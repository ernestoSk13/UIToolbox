//
//  SectionHeaderView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI

struct SectionHeaderView: View {
    var name: String
    var body: some View {
        HStack {
            Text(name).bold()
            Spacer()
        }.padding()
    }
}
