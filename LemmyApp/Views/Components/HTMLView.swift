//
//  HTMLView.swift
//  LemmyApp
//
//  Created by Avery Pierce on 1/24/21.
//

import WebKit
import SwiftUI

struct HTMLView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(htmlContent: "<p>Hello World</p><p><strong>Bold</strong><a href=\"http://www.example.com\">link</a></p>")
    }
}
