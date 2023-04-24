//
//  UserStorage.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import Foundation


protocol UserStorageProtocol {
    func load() -> LoginModelProtocol
    func saveToken(loginModelProtocol: LoginModelProtocol)
    func saveUserId(loginModelProtocol: LoginModelProtocol)
}

class UserStorage: UserStorageProtocol {
    
    private var storage =  UserDefaults.standard
    private var storageKey = "storageKey"
        
    func load() -> LoginModelProtocol {
        let token = storage.string(forKey: storageKey) ?? ""
        var veryToken:LoginModelProtocol = LoginModel()
        veryToken.token = token
        return veryToken
    }
    
    func saveToken(loginModelProtocol: LoginModelProtocol) {
        var token = ""
        token = loginModelProtocol.token!
        storage.set(token, forKey: storageKey)
    }
    func saveUserId(loginModelProtocol: LoginModelProtocol) {
        var id = ""
        id = loginModelProtocol.userId!
        storage.set(id, forKey: storageKey)
    }
    
}
