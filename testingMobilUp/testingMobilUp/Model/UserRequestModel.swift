//
//  Model.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import Foundation


protocol UserProtocolOAthVk {
    var uri_vk_app: String { get set }
    var client_id: String { get set }
    var redirect_uri: String { get set }
    var display: String { get set }
    var scope: String { get set }
    var response_type: String { get set }
    var code: String { get set }
    var client_secret: String { get set }
}


struct UserVk: UserProtocolOAthVk {
    var uri_vk_app: String
    var client_id: String
    var redirect_uri: String
    var display: String
    var scope: String
    var response_type: String
    var code: String
    var client_secret: String
}

