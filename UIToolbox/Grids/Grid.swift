//
//  Grid.swift
//  Regicide-UI
//
//  Created by Ernesto Sánchez Kuri on 27/03/20.
//  Copyright © 2020 Oracle America. All rights reserved.
//

import SwiftUI

public extension Grid where Item: Identifiable, ID == Item.ID {
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, viewForItem: viewForItem)
    }
}

public struct Grid<Item, ID, ItemView>: View where ID: Hashable, ItemView: View {
    private var items: [Item]
    private var id: KeyPath<Item,ID>
    private var viewForItem: (Item) -> ItemView
    
    public init(_ items: [Item], id: KeyPath<Item,ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        self.viewForItem = viewForItem
    }
    
    public var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        return ForEach(items, id: id) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id] } )
        return Group {
            if index != nil {
                viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: index!))
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static let images: [String] = ["thermometer", "cloud.moon.bolt.fill", "sunrise.fill",
                  "sun.max", "moon.fill", "cloud.rain",
                  "cloud.bolt.fill", "tornado", "hurricane"]
    
    static var previews: some View {
        Group {
            Grid(Grid_Previews.images, id: \.self, viewForItem: { image in
                Image(systemName: image)
            }).previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200, height: 200)
            .environment(\.colorScheme, .light)
            .previewDisplayName("3x3 Columns")
            
            Grid(Grid_Previews.images, id: \.self, viewForItem: { image in
                Image(systemName: image)
            }).previewLayout(.sizeThatFits)
            .background(Color(UIColor.systemBackground))
            .padding()
            .frame(width: 300, height: 150)
            .environment(\.colorScheme, .dark)
            .previewDisplayName("2 Rows")
            
            Grid(Array(Grid_Previews.images[3...6]), id: \.self, viewForItem: { image in
                Image(systemName: image)
            }).previewLayout(.sizeThatFits)
            .background(Color(UIColor.systemBackground))
            .padding()
            .frame(width: 150, height: 150)
            .environment(\.colorScheme, .dark)
            .previewDisplayName("2x2")
        }
    }
}

