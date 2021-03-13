//
//  SliderSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 06/01/21.
//

import SwiftUI
import SUITcase

struct SliderSampleView: View {
    @State var minValue: Double = 25
    @State var maxValue: Double = 75
    @State var editing = false
    @State var minText = ""
    @State var maxText = ""
    
    
    var body: some View {
        VStack {
            RangeSlider(measureName: "Reveneue",
                range: 0..<100,
                        minValue: $minValue,
                        maxValue: $maxValue,
                        minText: $minText,
                        maxText: $maxText,
                        moving: .constant(true),
                        editing: $editing)
        }.padding()
    }
}

struct SliderSampleView_Previews: PreviewProvider {
    static var previews: some View {
        SliderSampleView()
    }
}
