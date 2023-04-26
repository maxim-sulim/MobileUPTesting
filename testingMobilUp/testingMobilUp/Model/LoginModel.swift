//
//  LoginModel.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import Foundation

protocol LoginModelProtocol {
    var islogin: Bool { get }
    var token: String? { get set }
    var sessionToken: String? { get set }
    var userId: String? { get set }
}

struct LoginModel: LoginModelProtocol {
    var islogin: Bool {
        if token != nil {
            return true
        }
        return false
    }
    var token: String?
    var sessionToken: String?
    var userId: String?
}
