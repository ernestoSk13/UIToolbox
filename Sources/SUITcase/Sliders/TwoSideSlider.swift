//
//  TwoSideSlider.swift
//  SUITcase
//
//  Created by Ernesto Sánchez Kuri on 05/01/21.
//

import SwiftUI

public struct TwoSideSlider: UIViewRepresentable {
    var range: Range<Double>
    @Binding var minValue: Double
    @Binding var maxValue: Double
    @Binding var minText: String
    @Binding var maxText: String
    var insideTrackColor: UIColor = UIColor.sliderColor
    var outsideColor: UIColor = UIColor.lightGray
    var bgColor: UIColor = UIColor.clear
    @Binding var moving: Bool
    @Binding var editing: Bool
    
    public init(range: Range<Double>,
                minValue: Binding<Double>,
                maxValue: Binding<Double>,
                minText: Binding<String>,
                maxText: Binding<String>,
                selectedColor: UIColor = UIColor.blue,
                unselectedColor: UIColor = UIColor.lightGray,
                bgColor: UIColor = UIColor.clear,
                moving: Binding<Bool>,
                editing: Binding<Bool>) {
        self.range = range
        _minValue = minValue
        _maxValue = maxValue
        _minText = minText
        _maxText = maxText
        _moving = moving
        _editing = editing
        self.insideTrackColor = selectedColor
        self.outsideColor = unselectedColor
        self.bgColor = bgColor
    }
    
    public func makeUIView(context: Context) -> BIRangeSlider {
        let slider = BIRangeSlider(frame: .zero)
        slider.setRange(minimum: range.lowerBound, maximum: range.upperBound)
        slider.lowerValue = minValue
        slider.upperValue = maxValue
        slider.insideTrackColor = insideTrackColor
        slider.outsideTrackColor = outsideColor
        slider.backgroundColor = bgColor
        slider.delegate = context.coordinator
        return slider
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    public class Coordinator: BISliderDelegate {
        var parent: TwoSideSlider
        
        init(_ parent: TwoSideSlider) {
            self.parent = parent
        }
        
        public func sliderDidMove(slider: BISlider) {
            if let rangeSlider = slider as? BIRangeSlider {
                parent.minValue = Double(rangeSlider.lowerValue.roundedValue) ?? rangeSlider.lowerValue
                parent.maxValue = Double(rangeSlider.upperValue.roundedValue) ?? rangeSlider.upperValue
                parent.minText = "\(parent.minValue)"
                parent.maxText = "\(parent.maxValue)"
                parent.moving = true
                parent.editing = false
            }
        }
        
        public func sliderDidEndMovement(slider: BISlider) {
            if let rangeSlider = slider as? BIRangeSlider {
                parent.minValue = Double(rangeSlider.lowerValue.roundedValue) ?? rangeSlider.lowerValue
                parent.maxValue = Double(rangeSlider.upperValue.roundedValue) ?? rangeSlider.upperValue
                parent.minText = "\(parent.minValue)"
                parent.maxText = "\(parent.maxValue)"
                parent.moving = false
            }
        }
    }
    
    public func updateUIView(_ uiView: BIRangeSlider, context: Context) {
        uiView.lowerValue = minValue
        uiView.upperValue = maxValue
    }
}

public struct RangeSlider: View {
    var measureName: String
    var range: Range<Double>
    @Binding var minValue: Double
    @Binding var maxValue: Double
    @Binding var minText: String
    @Binding var maxText: String
    var selectedColor: UIColor = UIColor.systemBlue
    var unselectedColor: UIColor = UIColor.lightGray
    var bgColor: UIColor = UIColor.clear
    @Binding var moving: Bool
    @Binding var editing: Bool

    public init(measureName: String,
                range: Range<Double>,
                minValue: Binding<Double>,
                maxValue: Binding<Double>,
                minText: Binding<String>,
                maxText: Binding<String>,
                selectedColor: UIColor = UIColor.systemBlue,
                unselectedColor: UIColor = UIColor.lightGray,
                bgColor: UIColor = UIColor.clear,
                moving: Binding<Bool>,
                editing: Binding<Bool>) {
        self.measureName = measureName
        self.range = range
        _minValue = minValue
        _maxValue = maxValue
        _moving = moving
        _editing = editing
        _minText = minText
        _maxText = maxText
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.bgColor = bgColor
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text("\(Double.convertNumberWithNotation(number: range.lowerBound, decimals: true))")
                    .resizable(withSize: 10)
                    .foregroundColor(Color(UIColor.lightGray))
                Spacer()
                Text("\(Double.convertNumberWithNotation(number: range.upperBound, decimals: true))")
                    .resizable(withSize: 10)
                    .foregroundColor(Color(UIColor.lightGray))
            }
            TwoSideSlider(range: range,
                          minValue: $minValue,
                          maxValue: $maxValue,
                          minText: $minText,
                          maxText: $maxText,
                          selectedColor: selectedColor,
                          unselectedColor: unselectedColor,
                          bgColor: bgColor,
                          moving: $moving,
                          editing: $editing)
                .padding(.vertical, 1)
        }.frame(height: 60)
    }
}


struct TwoSideSlider_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TwoSideSlider(range: 0..<100,
                          minValue: .constant(25),
                          maxValue: .constant(75),
                          minText: .constant(""),
                          maxText: .constant(""),
                          moving: .constant(false),
                          editing: .constant(false))
                .padding()
            
            RangeSlider(measureName: "Revenue",
                        range: 0..<105_000.4,
                        minValue: .constant(10),
                        maxValue: .constant(50),
                        minText: .constant(""),
                        maxText: .constant(""),
                        moving: .constant(true),
                        editing: .constant(false))
                .padding()
        }
    }
}

