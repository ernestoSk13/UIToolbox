//
//  LazyCollection.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 23/09/20.
//

import SwiftUI

struct LazyCollection: View {
    let data = (1...1000).map { $0 }
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: columns, spacing: 10) {
                ForEach(data, id: \.self) { item in
                    SampleRow(id: item)
                }
            }
        }.frame(width: nil, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct SampleRow: View {
    let id: Int
    
    var body: some View {
        Text("Row \(id)")
    }
    
    init(id: Int) {
        print("Loading row \(id)")
        self.id = id
    }
}

@available(iOS 14.0, *)
struct LazyCollection_Previews: PreviewProvider {
    static var previews: some View {
        LazyCollection()
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200, height: 200)
            .environment(\.colorScheme, .light)
            .previewDisplayName("3x3 Columns")
    }
}
