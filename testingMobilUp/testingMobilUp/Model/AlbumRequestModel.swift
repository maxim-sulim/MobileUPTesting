//
//  AlbumRequestModel.swift
//  testingMobileUp
//
//  Created by Максим Сулим on 24.04.2023.
//

import Foundation

//https://api.vk.com/method/photos.get

protocol AlbumRequestModelProtocol {
    var owner_id: String { get set } //128666765
    var album_id: String { get set } //266310117
    var access_token: String { get set }
}


struct AlbomRequest: AlbumRequestModelProtocol {
    var owner_id: String
    var album_id: String
    var access_token: String
}

//parsing

struct Albums: Decodable {
    var response: Album
}

struct Album: Decodable {
    var items: [Image]
    var count: Int
}

struct Image: Decodable {
    var sizes: [InfoImage]
    var date: Int //doubl?
    
    }

struct InfoImage: Decodable {
    var height: Int
    var width: Int
    var url: String
    
}
