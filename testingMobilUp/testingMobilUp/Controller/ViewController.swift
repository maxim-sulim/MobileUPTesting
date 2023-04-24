//
//  ViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit

class ViewController: UIViewController, DataUpdateLogProtocol {
    
    
    var isLogin = true
    
    func loginCheck(isLogin: Bool) {
        self.isLogin = isLogin
    }
    
    @IBOutlet weak var vkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
   
    @IBAction func authorizationVkButton(_ sender: Any) {
        
        if isLogin == true {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editStrean = storyboard.instantiateViewController(withIdentifier: "showCollection") as! CollectionViewController
            self.navigationController?.pushViewController(editStrean, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editStrean = storyboard.instantiateViewController(withIdentifier: "showWebView") as! AuthorizationViewController
            // устанавливаем текущий класс в качестве делегата
            editStrean.handleCheckLogDelegate = self
            self.navigationController?.pushViewController(editStrean, animated: true)
            self.dismiss(animated: true)
        }
    }
    
    
}

