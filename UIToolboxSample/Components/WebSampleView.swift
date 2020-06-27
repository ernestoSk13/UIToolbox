//
//  WebSampleView.swift
//  UIToolboxSample
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import UIToolbox

struct WebSampleView: View {
    var body: some View {
        ZStack {
            ActivityIndicator()
            VStack {
                WebView(request: URLRequest(url: URL(string: "https://www.oracle.com")!))
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebSampleView_Previews: PreviewProvider {
    static var previews: some View {
        WebSampleView()
    }
}
