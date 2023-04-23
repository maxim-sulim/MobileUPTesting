//
//  SegmetCollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 23.04.2023.
//

import UIKit

class SegmetCollectionViewController: UIViewController {

    @IBOutlet weak var segmentCollection: UICollectionView!
    
    var imageCollectionArray:[AlbumModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    

}


extension SegmetCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "almubCell", for: indexPath) as? CollectionViewCell {
            itemCell.album = imageCollectionArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
}
