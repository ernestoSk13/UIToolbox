//
//  SimpleSlider.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI

public struct SliderComponents {
    public let barLeft: SliderModifier
    public let barRight: SliderModifier
    public let indicator: SliderModifier
}

public struct SliderModifier: ViewModifier {
    enum Name {
        case left
        case right
        case indicator
    }
    
    let name: Name
    let size: CGSize
    let offset: CGFloat
    
    public func body(content: Content) -> some View {
        content
            .frame(width: size.width)
            .position(x: size.width * 0.5, y: size.height * 0.5)
            .offset(x: offset)
    }
}

public struct CustomSlider<Component: View>: View {
    @Binding var value: Double
    var range: (Double, Double)
    var indicatorWidth: CGFloat?
    let viewBuilder: (SliderComponents) -> Component
    
    public init(value: Binding<Double>,
                range: (Double, Double),
                indicatorWidth: CGFloat? = nil,
                _ viewBuilder: @escaping (SliderComponents) -> Component) {
        _value = value
        self.range = range
        self.indicatorWidth = indicatorWidth
        self.viewBuilder = viewBuilder
    }
    
    public var body: some View {
        return GeometryReader { geometry in
            view(geometry: geometry)
        }
    }
    
    private func view(geometry: GeometryProxy) -> some View {
        let frame = geometry.frame(in: .global)
        let drag = DragGesture(minimumDistance: 0).onChanged { (drag) in
            self.onDragChange(drag, frame)
        }
        let offsetX = getOffsetX(frame: frame)
        let indicatorSize = CGSize(width: indicatorWidth ?? frame.height, height: frame.height)
        let barLeftSize = CGSize(width: CGFloat(offsetX + indicatorSize.width + 0.5), height: frame.height)
        let barRightSize = CGSize(width: frame.width - barLeftSize.width, height: frame.height)
        
        let modifiers = SliderComponents(barLeft: SliderModifier(name: .left,
                                                                 size: barLeftSize,
                                                                 offset: 0),
                                         barRight: SliderModifier(name: .right,
                                                                  size: barRightSize,
                                                                  offset: barLeftSize.width),
                                         indicator: SliderModifier(name: .indicator,
                                                                   size: indicatorSize,
                                                                   offset: offsetX))
        return ZStack {
            viewBuilder(modifiers).gesture(drag)
        }
    }
    
    private func onDragChange(_ drag: DragGesture.Value, _ frame: CGRect) {
        let width = (indicator: Double(indicatorWidth ?? frame.height), view: Double(frame.size.width))
        let xRange = (min: Double(0), max: Double(width.view - width.indicator))
        var value = Double(drag.startLocation.x + drag.translation.width)
        value -= 0.5 * width.indicator
        value = value > xRange.max ? xRange.max : value
        value = value < xRange.min ? xRange.min : value
        value = value.convert(fromRange: (xRange.min, xRange.max), toRange: range)
        self.value = value
    }
    
    private func getOffsetX(frame: CGRect) -> CGFloat {
        let width = (indicator: indicatorWidth ?? frame.size.height, view: frame.size.width)
        let xRange: (Double, Double) = (0, Double(width.view - width.indicator))
        let result = self.value.convert(fromRange: range, toRange: xRange)
        return CGFloat(result)
    }
}
