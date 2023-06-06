//
//  SegmentCollectionViewCell.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var segmentImage: UIImageView!
    var album: AlbumModel? {
        didSet {
            guard let image = album?.imageAlbomData else { return }
                segmentImage.image = UIImage(data: image)
                segmentImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
