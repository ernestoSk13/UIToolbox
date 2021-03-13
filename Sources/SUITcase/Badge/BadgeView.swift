//
//  BadgeView.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 09/03/21.
//

import SwiftUI

public struct BadgeView<BadgeText>: View where BadgeText: View {
    let color: Color
    let minHeight: CGFloat
    var badgeText: BadgeText
    
    public init(color: Color,
                minHeight: CGFloat = 20,
                @ViewBuilder badgeText: () -> BadgeText) {
        self.color = color
        self.badgeText = badgeText()
        self.minHeight = minHeight
    }
    
    public var body: some View {
        badgeText
            .padding(.all, minHeight / 4)
            .frame(minWidth: minHeight)
            .frame(width: nil, height: minHeight)
            .background(color)
            .clipped()
            .cornerRadius(minHeight * 0.5)
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                BadgeView(color: .blue,
                          minHeight: 16, badgeText: {
                            Text("1")
                                .font(.caption)
                                .foregroundColor(Color.yellow)
                          })
                    .frame(width: nil, height: 30)
            }
        }
    }
}
