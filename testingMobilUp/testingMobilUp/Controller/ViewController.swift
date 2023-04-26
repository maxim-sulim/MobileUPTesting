//
//  ViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, DataUpdateLogProtocol {
    
    
    private var storage: UserStorageProtocol = UserStorage()
    
    var token: LoginModelProtocol {
        storage.load()
    }
    
    func loginCheck() {
        if token.islogin == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editStrean = storyboard.instantiateViewController(withIdentifier: "showCollection")
            editStrean.modalPresentationStyle = .fullScreen
            self.present(editStrean, animated: true)
        }
    }
    
    @IBOutlet weak var vkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginCheck()
    }
   
    @IBAction func authorizationVkButton(_ sender: Any) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editStrean = storyboard.instantiateViewController(withIdentifier: "showWebView") as! AuthorizationViewController
            // устанавливаем текущий класс в качестве делегата
            editStrean.handleCheckLogDelegate = self
            self.present(editStrean, animated: true)
    }
}

