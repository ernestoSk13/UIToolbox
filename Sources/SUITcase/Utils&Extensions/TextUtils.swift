//
//  TextUtils.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 08/10/20.
//

import SwiftUI

enum FontSize: CGFloat {
    case title = 28
    case body = 17
    case callout = 16
    case subhead = 15
    case footnote = 13
    case caption = 11
}

struct CustomFont: ViewModifier {
    var fontName: String?
    var size: FontSize
    func body(content: Content) -> some View {
        content
            .font(fontName == nil ? Font.system(size: size.rawValue) : Font.custom(fontName ?? "", size: size.rawValue))
    }
}

struct CustomSizableFont: ViewModifier {
    var fontName: String?
    var size: CGFloat
    func body(content: Content) -> some View {
        content
            .font(fontName == nil ? Font.system(size: size) : Font.custom(fontName ?? "", size: size))
    }
}

public extension View {
    func title(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .title))
    }
    
    func body(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .body))
    }
    
    func callout(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .callout))
    }
    
    func caption(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .caption))
    }
    
    func footnote(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .footnote))
    }
    
    func subhead(font: String? = nil) -> some View {
        self.modifier(CustomFont(fontName: font, size: .subhead))
    }
    
    func resizable(font: String? = nil, withSize size: CGFloat) -> some View {
        self.modifier(CustomSizableFont(fontName: font, size: size))
    }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
