//
//  CollectionViewCell.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageAlbum: UIImageView!
    
    var album: AlbumModel? {
        didSet {
            if let image = album?.imageAlbomData {
                imageAlbum.image = UIImage(data: image)
                imageAlbum.translatesAutoresizingMaskIntoConstraints = false
                imageAlbum.backgroundColor = .gray
            }
        }
    }
}
