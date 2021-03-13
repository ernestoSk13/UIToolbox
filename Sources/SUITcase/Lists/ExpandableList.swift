//
//  ExpandableList.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 04/09/20.
//

import SwiftUI

class Item: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID = UUID()
    var parent: Item? = nil
    var title: String
    var level: Int
    var iconName: String? = nil
    
    init(title: String, parent: Item? = nil, level: Int = 0) {
        self.title = title
        self.parent = parent
        self.level = level
    }
    
    func increaseLevelFor(items: Item...) {
        items.forEach { item in
            item.parent = self
        }
    }
    
    func increaseLevelFor(items: [Item]) {
        items.forEach { item in
            item.parent = self
        }
    }
}

public struct Items {
    var items: [Item] = []
}

@_functionBuilder
struct ItemsBuilder {
    static func buildBlock(_ item: Item) -> Item {
        item
    }
    
    static func buildBlock(_ subitems: Item...) -> Items {
        .init(items: subitems)
    }
}

class Folder: Item {
    typealias Action = (_ indexPath: IndexPath, _ title: String, _ isExpanded: Bool) -> Void
    
    var subitems: [Item] = []
    var chevronVisible = true
    var isExpanded = true
    
    var animationDuration: TimeInterval = 0.3
    
    var isGroup: Bool {
        return subitems.count > 0
    }
    
    private(set) var action: Action?
    var defaultImageName = "folder"
    
     public init(title: String,
                   isExpanded: Bool = false,
                   isItemsCountVisible: Bool = false,
                   action: Action? = nil) {
           super.init(title: title)
           self.isExpanded = isExpanded
           self.action = action
           
           configureDefaults()
       }
    
    public init(title: String,
                isExpanded: Bool = false,
                isItemsCountVisible: Bool = false,
                action: Action? = nil,
                @ItemsBuilder subitems: () -> Items) {
        super.init(title: title)
        self.isExpanded = isExpanded
        self.action = action
        
        configureDefaults()
        
        let subitems = subitems().items
        increaseLevelFor(items: subitems)
        self.subitems = subitems
    }
    
    public init(title: String,
                isExpanded: Bool = false,
                isItemsCountVisible: Bool = false,
                action: Action? = nil,
                @ItemsBuilder subitems: () -> Item) {
        super.init(title: title)
        self.isExpanded = isExpanded
        self.action = action
        
        configureDefaults()
        
        let subitems = [subitems()]
        increaseLevelFor(items: subitems)
        self.subitems = subitems
    }
    
    @discardableResult
    func remove(at index: Int) -> Self {
        subitems.remove(at: index)
        return self
    }
    
    @discardableResult
      public func isExpanded(_ isExpanded: Bool) -> Self {
          self.isExpanded = isExpanded
          return self
      }
    
      @discardableResult
      public func addItem(@ItemsBuilder build: () -> Items) -> Self {
          let items = build().items
          increaseLevelFor(items: items)
          subitems += items
          return self
      }

      @discardableResult
      public func addItems(_ items: Item...) -> Self {
          increaseLevelFor(items: items)
          subitems += items
          return self
      }
      
      @discardableResult
      public func addItems(_ items: [Item]) -> Self {
          increaseLevelFor(items: items)
          subitems += items
          return self
      }
    
    @discardableResult
    public func isChevronVisible(_ isChevronVisible: Bool) -> Self {
        self.chevronVisible = isChevronVisible
        return self
    }
    
    @discardableResult
    public func setChevronAnimationDuration(_ chevronAnimationDuration: TimeInterval) -> Self {
        self.animationDuration = chevronAnimationDuration
        return self
    }
    
    @discardableResult
    public func setAction(_ action: @escaping Action) -> Self {
        self.action = action
        return self
    }
}

extension Folder {
    func configureDefaults() {
        self.iconName = defaultImageName
    }
}

class Column: Item {
    public typealias Action = (_ indexPath: IndexPath, _ title: String) -> Void
    public private(set) var action: Action?
    
    let defaultImageName = "circle.fill"
    //private let defaultTintColor = UIColor.systemTeal
    
    public init(title: String,
                action: @escaping Action) {
        super.init(title: title)
        
        self.action = action
        
        //tintColor = defaultTintColor
        iconName = defaultImageName
    }
    
//    public init(title: String,
//                action: Action? = nil,
//                viewControllerType: UIViewController.Type? = nil,
//                configuration: ((UIViewController) -> Void)? = nil) {
//        super.init(title: title)
//
//        //tintColor = defaultTintColor
//        imageName = defaultImageName
//
//        self.viewControllerType = viewControllerType
//        self.configuration = configuration
//    }
    @discardableResult
    public func setAction(_ action: @escaping Action) -> Self {
        self.action = action
        return self
    }
}


struct ExpandableCell: View {
    let item: Item
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: item.iconName ?? "")
                Text(item.title)
                Spacer()
                if item is Folder {
                    Image(systemName: "chevron.right")
                }
            }
        }
    }
}

struct ColumnCell: View {
    let column: Column
    
    var body: some View {
        HStack {
            Image(systemName: column.defaultImageName)
            Text(column.title)
            Spacer()
        }.padding()
    }
}

struct ExpandableList: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "folder")
                    Text("Root")
                    Spacer()
                }.padding()
            }
        }
    }
}

struct ExpandableList_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableList()
    }
}
