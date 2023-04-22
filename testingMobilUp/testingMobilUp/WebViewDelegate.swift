//
//  WebViewDelegate.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 22.04.2023.
//

import UIKit
import WebKit

class WebViewDelegate: WKWebView, WKNavigationDelegate {
    
    var webView: WKWebView!
    var token = LoginModel().token
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url,
                     url.path == "/blank.html",
                     let fragment = url.fragment  else { return }
               let parsing = fragment.components(separatedBy: "&")
                   .map{$0.components(separatedBy: "=")} .reduce([String:String]()) {
                       res, pars in
                       var dict = res
                       let key = pars[0]
                       let value = pars[1]
                       dict[key] = value
                       return dict
                   }
               if let accessTocen = parsing["access_token"] {
                   LoginModel().token = accessTocen
               } else {
                   //alert error
               }
    }
    
    }
    
