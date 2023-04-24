//
//  AlbumModel.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import Foundation

protocol AlbumModelProtocol {
    //var idAlbum: String { get set }
    var imageAlbomData: String { get set } //data
    //var imageCount: Int { get set }
}



struct AlbumModel: AlbumModelProtocol {
    var imageAlbomData: String //data
    //var imageCount: Int
    //var imageDataUnix: "String"
    //var urlImage: "String"
}
