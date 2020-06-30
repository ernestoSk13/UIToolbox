//
//  BottomSheet.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
fileprivate enum BottomsheetConstants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.20
}

public struct BottomSheet<Content: View>: View {
    @Binding var isOpen: Bool
    let maxHeight: CGFloat
    var minHeight: CGFloat = 0
    let content: Content
    @GestureState private var translation: CGFloat = 0
    let presentedPortion: CGFloat
    var minHeightRatio: CGFloat {
        return (self.currentDeviceHeight * self.presentedPortion) * 0.1
    }
    var backgroundColor: Color
    
    var currentDeviceWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    var currentDeviceHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public init(isOpen: Binding<Bool>,
         maxHeight: CGFloat,
         presentedPortion: CGFloat,
         @ViewBuilder content: () -> Content,
                      backgroundColor: Color = Color(UIColor.systemBackground)) {
        self.maxHeight = maxHeight
        self.content = content()
        self.presentedPortion = presentedPortion
        self._isOpen = isOpen
        self.backgroundColor = backgroundColor
        if UIDevice.isIpad {
            self.minHeight = self.currentDeviceHeight > 1000 ? self.currentDeviceHeight * 0.08 : self.currentDeviceHeight * 0.1
        } else {
            self.minHeight = UIDevice.isLandscape ? self.currentDeviceHeight * 0.2 : self.currentDeviceHeight * 0.1
        }
    }
    
    private var offset: CGFloat {
        self.isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomsheetConstants.radius)
            .fill(Color.clear)
            .frame(width: BottomsheetConstants.indicatorWidth,
                   height: BottomsheetConstants.indicatorHeight)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(self.backgroundColor)
            .cornerRadius(12)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
        .clipped()
        .shadow(radius: 2)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * BottomsheetConstants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BottomSheet(isOpen: .constant(true), maxHeight: 400, presentedPortion: 0.3) {
                VStack {
                    HStack {
                        Text("Sample").padding()
                        Spacer()
                    }
                }
            }.background(Color.black)
            
            BottomSheet(isOpen: .constant(true), maxHeight: 400, presentedPortion: 0.3) {
                VStack {
                    HStack {
                        Text("Sample").padding()
                        Spacer()
                    }
                }
            }.environment(\.colorScheme, .dark)
        }
    }
}
#endif
