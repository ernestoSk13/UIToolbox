//
//  ActivityIndicatorSampleView.swift
//  SUITcaseSample
//
//  Created by Ernesto Sánchez Kuri on 12/08/20.
//

import SwiftUI
import SUITcase

struct ActivityIndicatorSampleView: View {
    var body: some View {
        ZStack {
            VStack {
                ActivityIndicator(color: .gray, style: .large)
                Text("Sample Indicator")
            }
        }
    }
}

struct ActivityIndicatorSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorSampleView()
    }
}
