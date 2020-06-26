//
//  WebView.swift
//  UIToolbox
//
//  Created by Ernesto Sánchez Kuri on 26/06/20.
//  Copyright © 2020 Ernesto Sánchez Kuri. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    func makeCoordinator() -> WebView.Coordinator {
        Coordinator(self)
    }
    
    let request: URLRequest
    var firstRequestFinished = false
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView?
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
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
