//
//  BottomSheet.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// Constants used to build  a bottom sheet with a custom content.
fileprivate enum BottomsheetConstants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.20
}

/// A Partial View that will appear at the bottom of the screen. A `Content`view will be attached to the body.
public struct BottomSheet<Content: View>: View {
    /// Determines if the sheet is partially or fully viewed.
    @Binding var isOpen: Bool
    /// The maximum height that will be shown if `isOpen` is true
    let maxHeight: CGFloat
    /// The minimum height that will be shown if `isOpen` is false
    var minHeight: CGFloat = 0
    /// A Content that will be sent by the user and will be presented inside the current sheet
    let content: Content
    /// A `State` that will indicate the current translation of the view caused by the  user's gesture.
    @GestureState private var translation: CGFloat = 0
    /// The portion that will be presented. This measure is relative to the max height
    let presentedPortion: CGFloat
    /// The minimum default portion shown.
    var minHeightRatio: CGFloat {
        return (self.currentDeviceHeight * self.presentedPortion) * 0.1
    }
    /// The backgrouind color of the sheet.
    var backgroundColor: Color
    
    var currentDeviceWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    var currentDeviceHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    var showIndicator: Bool
    
    /// Initializes a Bottom sheet with the minimum requested information.
    /// - Parameters:
    ///   - isOpen: Determines if the sheet is partially or fully viewed.
    ///   - maxHeight: The maximum height that will be shown if `isOpen` is true
    ///   - presentedPortion: The minimum height that will be shown if `isOpen` is false
    ///   - showIndicator: Determines if a drag indicator should be shown at top. By default is set to `false`
    ///   - content: A Content that will be sent by the user and will be presented inside the current sheet
    ///   - backgroundColor: The backgrouind color of the sheet.
    public init(isOpen: Binding<Bool>,
         maxHeight: CGFloat,
         presentedPortion: CGFloat,
         showIndicator: Bool = false,
         @ViewBuilder content: () -> Content,
                      backgroundColor: Color = Color(UIColor.systemBackground)) {
        self.maxHeight = maxHeight
        self.content = content()
        self.presentedPortion = presentedPortion
        self._isOpen = isOpen
        self.showIndicator = showIndicator
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
    
    /// A rectangular view that will be used as reference for the user to drag the current sheet.
    private var indicator: some View {
        RoundedRectangle(cornerRadius: BottomsheetConstants.radius)
            .fill(Color.primary)
            .frame(width: BottomsheetConstants.indicatorWidth,
                   height: BottomsheetConstants.indicatorHeight)
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                if self.showIndicator {
                    self.indicator.offset(x: 0, y: 20)
                }
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
            BottomSheet(isOpen: .constant(true),
                        maxHeight: 400,
                        presentedPortion: 0.3,
                        showIndicator: true) {
                VStack {
                    HStack {
                        Text("Sample").padding()
                        Spacer()
                    }
                }
            }.background(Color.gray).edgesIgnoringSafeArea(.bottom)
            
            BottomSheet(isOpen: .constant(true), maxHeight: 400, presentedPortion: 0.3, showIndicator: true) {
                VStack {
                    HStack {
                        Text("Sample").padding()
                        Spacer()
                    }
                }
            }.edgesIgnoringSafeArea(.bottom).environment(\.colorScheme, .dark)
        }
    }
}
#endif
