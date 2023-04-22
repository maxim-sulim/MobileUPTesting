//
//  AuthorizationViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController, WKNavigationDelegate  {
    
    var user: UserProtocolOAthVk = UserVk(uri_vk_app: "https://oauth.vk.com/authorize?",
                                          client_id: "51623269",
                                          redirect_uri: "https://oauth.vk.com/blank.html",
                                          display: "popup",
                                          scope: "offline",
                                          response_type: "token")
    
    let sessionCinfiguration = URLSessionConfiguration.default
    private var dataTask: URLSessionDataTask?
    
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
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      /*  view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authorizationVk()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
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
                   
               }
    }
    
    private func authorizationVk () {
        
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: user.client_id),
            URLQueryItem(name: "redirect_uri", value: user.redirect_uri),
            URLQueryItem(name: "display", value: user.display),
            //URLQueryItem(name: "scope", value: user.scope),
            URLQueryItem(name: "response_type=", value: user.response_type)
        ]
        
            DispatchQueue.main.async {
                let urlRequest = URLRequest(url: urlComp.url!)
                self.webView.load(urlRequest)
            }
    }
    
}

