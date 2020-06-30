//
//  ActivityIndicator.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
#if targetEnvironment(macCatalyst) || os(iOS)
/// A `UIViewReprentable` that will draw an activity indicator that is used to give user a feedback when something is loading in the background
public struct ActivityIndicator: UIViewRepresentable {
    let color: UIColor
    let style: UIActivityIndicatorView.Style
    
    /// Creates an Activity Indicator instance.
    /// - Parameters:
    ///   - color: the color of tha activity indicator view
    ///   - style: A constant that specifies the style of the object to be created. by defailt it is set to `.large`
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
