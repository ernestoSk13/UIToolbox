//
//  WebView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import WebKit
#if targetEnvironment(macCatalyst) || os(iOS)
/// A `UIViewRepresentable` of `WKWebView` that can be used in SwiftUI
public struct WebView: UIViewRepresentable {
    public func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }
    let request: URLRequest
    @Environment(\.presentationMode) var presentationMode
    
    /// Creates an instance of `WKWebView`
    /// - Parameters:
    ///   - request: The request specifying the URL to navigate to.
    public init(request: URLRequest) {
        self.request = request
    }
    
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView?
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) { }
}

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WebView(request: URLRequest(url: URL(string:"www.apple.com")!))
        }
    }
}
#endif
