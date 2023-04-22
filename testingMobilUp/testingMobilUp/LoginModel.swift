//
//  LoginModel.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit


protocol LoginModelProtocol {
    var islogin: Bool { get set }
    var token: String { get set }
}

class LoginModel: LoginModelProtocol {

    var islogin = false
    
    var token = "" {
        didSet {
            islogin = true
        }
    }
    
    
}
