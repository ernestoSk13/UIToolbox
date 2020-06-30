//
//  ActivityIndicator.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
public struct ActivityIndicator: UIViewRepresentable {
    let color: UIColor
    let style: UIActivityIndicatorView.Style

    public init(color: UIColor = UIColor.lightGray, style: UIActivityIndicatorView.Style = .large) {
        self.color = color
        self.style = style
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.color = color
        activityIndicator.startAnimating()
        return activityIndicator
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
 
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(color: .gray, style: .large)
    }
}
#endif
