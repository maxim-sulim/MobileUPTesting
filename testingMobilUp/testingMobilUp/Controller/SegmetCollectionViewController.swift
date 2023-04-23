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
        self.segmentCollection.delegate = self
        self.segmentCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        segmentCollection.reloadData()
    }

    

}


extension SegmetCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "almubCell", for: indexPath) as? SegmentCollectionViewCell {
            itemCell.album = imageCollectionArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
}
