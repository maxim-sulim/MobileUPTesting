//
//  SegmentCollectionViewCell.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var segmentImage: UIImageView! {
        didSet {
            guard let image = album?.imageAlbomData else { return }
            segmentImage.image = UIImage(systemName: image)
        }
    }
    
    var album: AlbumModel?
    
}
