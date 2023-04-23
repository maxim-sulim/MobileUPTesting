//
//  ViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var vkButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func authorizationVkButton(_ sender: Any) {
        
    }
    
    private func loginCheck (login: Bool) {
        if login {
            self.navigationController?.pushViewController(CollectionViewController(), animated: false)
        }
    }
}

