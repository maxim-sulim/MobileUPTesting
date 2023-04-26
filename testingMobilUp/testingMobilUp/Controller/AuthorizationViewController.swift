//
//  AuthorizationViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate  {
    
   private var storage: UserStorageProtocol = UserStorage()
  
   private var user: UserProtocolOAthVk = UserVk(uri_vk_app: "https://oauth.vk.com/authorize?",
                                          client_id: "51623269",
                                          redirect_uri: "https://oauth.vk.com/blank.html",
                                          display: "popup",
                                          scope: "photos",
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
        super.viewDidDisappear(animated)
        attemptOut()
    }
    
    private func outError() {
        let error = UIAlertController(title: "Ошибка подключения", message: "Просите", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        error.addAction(cancel)
        self.present(error, animated: true)
    }
    private func attemptOut() {
        let alertController = UIAlertController(title: "Предупреждение", message: "точно выйти?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let dontCancel = UIAlertAction(title: "Нет", style: .default)
        alertController.addAction(dontCancel)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
    
    //MARK: раобота с сетью
    
    //запрашивает у делегата разрешение на переход к новому контенту после того , как известен ответ на запрос
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        guard let url = webView.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            return .allow
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
        if let accessToken = parsing["access_token"],
           let sessionSec = parsing["expire_in"],
           let userIdStr = parsing["user_id"] {
        
            let loginModel = LoginModel(token: accessToken,
                                        sessionToken: sessionSec,
                                        userId: userIdStr)
            
            storage.save(loginModelProtocol: loginModel)
                        
            self.dismiss(animated: true) {
                   // переход через делегат
                self.handleCheckLogDelegate?.loginCheck()
              }
        } else {
            outError()
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
    // получение токена, если будем использовать code
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
