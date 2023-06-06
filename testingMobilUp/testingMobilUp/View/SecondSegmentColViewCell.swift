//
//  SecondSegmentColViewCell.swift
//  testingMobileUp
//
//  Created by Максим Сулим on 27.04.2023.
//

import UIKit


class SecondSegmentColViewCell: UICollectionViewCell {
    
    @IBOutlet weak var secondImage: UIImageView!
    
    var album: AlbumModel? {
        didSet {
            guard let image = album?.imageAlbomData else { return }
                secondImage.image = UIImage(data: image)
                secondImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
