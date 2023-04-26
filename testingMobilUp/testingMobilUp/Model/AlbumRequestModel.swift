//
//  AlbumRequestModel.swift
//  testingMobileUp
//
//  Created by Максим Сулим on 24.04.2023.
//

import Foundation

protocol AlbumRequestModelProtocol {
    var owner_id: String { get set } 
    var album_id: String { get set }
    var access_token: String { get set }
}


struct AlbomRequest: AlbumRequestModelProtocol {
    var owner_id: String
    var album_id: String
    var access_token: String
}

//MARK: модель для парсинга JSON

struct Albums: Decodable {
    var response: Album
}

struct Album: Decodable {
    var items: [Image]
    var count: Int
}

struct Image: Decodable {
    var sizes: [InfoImage]
    var date: Int 
    
    }

struct InfoImage: Decodable {
    var height: Int
    var width: Int
    var url: String
    
}
