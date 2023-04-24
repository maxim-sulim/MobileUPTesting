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

struct Albums {
    var response: Album
}

struct Album {
    var item: [Image]
}

struct Image {
    var size: [InfoImage]
    var date: Int //doubl?
    
    }

struct InfoImage: Decodable {
    var widthImage: Int//d?
    var heightImage: Int//double?
    var urlImage: String
    
    enum CodingKeys: String, CodingKey {
        case widthImage = "width"
        case heightImage = "height"
        case urlImage = "url"
    }
}
