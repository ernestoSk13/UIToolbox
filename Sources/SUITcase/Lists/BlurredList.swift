//
//  BlurredList.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 27/08/20.
//

import SwiftUI

struct BlurredList: View {
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
            VStack(alignment: .leading, spacing: 2) {
                Text("Revenue").title()
                Text("Sales")
            }
        }
        .frame(width: 300, height: 30)
    }
}

struct BlurredList_Previews: PreviewProvider {
    static var previews: some View {
        BlurredList()
    }
}

extension Color {
    static let blurredWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}
