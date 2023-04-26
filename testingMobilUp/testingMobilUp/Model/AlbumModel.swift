//
//  AlbumModel.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import Foundation

protocol AlbumModelProtocol {
    var imageAlbomData: Data? { get set }
    var imageDateUnix: Date? { get set }
}

struct AlbumModel: AlbumModelProtocol {
    var imageAlbomData: Data?
    var imageDateUnix: Date?
}
