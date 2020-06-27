//
//  WebView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }
    
    let request: URLRequest
    var firstRequestFinished: Bool
    @Environment(\.presentationMode) var presentationMode
    
    public init(request: URLRequest, firstRequestFinished: Bool = false) {
        self.request = request
        self.firstRequestFinished = firstRequestFinished
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
