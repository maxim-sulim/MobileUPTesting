//
//  UserStorage.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import Foundation


protocol UserStorageProtocol {
    func load() -> LoginModelProtocol
    func save(loginModelProtocol: LoginModelProtocol)
}

class UserStorage: UserStorageProtocol {
    
    private var storage =  UserDefaults.standard
    private var storageKey = "storageKey"
        
    func load() -> LoginModelProtocol {
        var token = storage.string(forKey: storageKey) ?? ""
        var veryToken:LoginModelProtocol = LoginModel()
        veryToken.token = token
        return veryToken
    }
    
    func save(loginModelProtocol: LoginModelProtocol) {
        var token = ""
        token = loginModelProtocol.token!
        storage.set(token, forKey: storageKey)
    }
    
}
