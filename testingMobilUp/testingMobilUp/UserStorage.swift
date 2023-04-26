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
    func removeAll()
}

class UserStorage: UserStorageProtocol {
    
    private var storage =  UserDefaults.standard
    private var storageTokenKey = "storageKey"
    private var storageUserKey = "storageUserKey"
    private var storageSession = "storageSession"
        
    func load() -> LoginModelProtocol {
        let token = storage.string(forKey: storageTokenKey)
        var veryToken:LoginModelProtocol = LoginModel()
        veryToken.token = token
        return veryToken
    }
    
    
    func save(loginModelProtocol: LoginModelProtocol) {
        let token = loginModelProtocol.token
        let sessionToken = loginModelProtocol.sessionToken
        let userId = loginModelProtocol.userId
        storage.set(token, forKey: storageTokenKey)
        storage.set(sessionToken, forKey: storageSession)
        storage.set(userId, forKey: storageUserKey)
    }
    func removeAll() {
        storage.removeObject(forKey: storageTokenKey)
        storage.removeObject(forKey: storageUserKey)
        storage.removeObject(forKey: storageSession)
        
    }
}
