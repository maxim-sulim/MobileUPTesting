//
//  AuthorizationViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate  {
    
    var storage: UserStorageProtocol = UserStorage()
    var codeToken: String?
    
    var user: UserProtocolOAthVk = UserVk(uri_vk_app: "https://oauth.vk.com/authorize?",
                                          client_id: "51623269",
                                          redirect_uri: "https://oauth.vk.com/blank.html",
                                          display: "popup",
                                          scope: "offline",
                                          response_type: "token",
                                          code: "",
                                          client_secret: "Pqqa7HR9Q0SKGngdtrUa")
    
    let sessionCinfiguration = URLSessionConfiguration.default
    private var dataTask: URLSessionDataTask?
    
    var webView: WKWebView!
    
    var modelToken:LoginModelProtocol = LoginModel()
    var userId:LoginModelProtocol = LoginModel()
    var sessionToken:LoginModelProtocol = LoginModel()
    var handleCheckLogDelegate: DataUpdateLogProtocol?
    
  //MARK: работа жизненого цикла
    
    override func loadView() {
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            //webView.uiDelegate
            webView.navigationDelegate = self
        
            view = webView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authorizationVk()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        let alertController = UIAlertController(title: "Предупреждение", message: "точно выйти?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
        
    }
    
    //MARK: раобота с сетью
    
    //запрашивает у делегата разрешение на переход к новому контенту после того , как известен ответ на запрос
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        guard let url = webView.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            return .allow//alert
        }
        
        let parsing = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")} .reduce([String:String]()) {
                res, pars in
                var dict = res
                let key = pars[0]
                let value = pars[1]
                dict[key] = value
                return dict
            }
        if let accessTocen = parsing["access_token"],
           let sessionSec = parsing["expires_in"],
           let userIdStr = parsing["user_id"] {
        
            userId.userId = userIdStr
            //storage.save(loginModelProtocol: userId)
            sessionToken.sessionToken = sessionSec
            modelToken.token = accessTocen
            //storage.save(loginModelProtocol: modelToken)
            
            self.dismiss(animated: true) {
                   // переход через делегат
                self.handleCheckLogDelegate?.loginCheck(isLogin: true)
            
              }
        } else {
            //alert
        }
        return .cancel
    }

    
    // запрос на авторизацию
    private func authorizationVk () {
        
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/authorize"
        
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: user.client_id),
            URLQueryItem(name: "redirect_uri", value: user.redirect_uri),
            URLQueryItem(name: "display", value: user.display),
            URLQueryItem(name: "response_type", value: user.response_type)
        ]
        
            DispatchQueue.main.async {
                let urlRequest = URLRequest(url: urlComp.url!)
                self.webView.load(urlRequest)
            }
    }
    // запрос на получение токена
    private func parsToken (code: String) {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "oauth.vk.com"
        urlComp.path = "/access_token"
        
        urlComp.queryItems = [
            URLQueryItem(name: "client_id", value: user.client_id),
            URLQueryItem(name: "client_secret", value: user.client_secret),
            URLQueryItem(name: "redirect_uri", value: user.redirect_uri),
            URLQueryItem(name: "code", value: code)
        ]
        
        DispatchQueue.main.async {
            let urlRequest = URLRequest(url: urlComp.url!)
            self.webView.load(urlRequest)
        }
    }
    
    
}
