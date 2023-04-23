//
//  CollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit

class CollectionViewController: UIViewController {
   
    @IBOutlet weak var albumCollection: UICollectionView!
    
    var imageCollectionArray:[AlbumModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageCollection()
        albumCollection.dataSource = self
        albumCollection.delegate = self
        
    }
    
    func loadImageCollection() {
        imageCollectionArray.append(AlbumModel(imageAlbomData: "heart.fill"))
        imageCollectionArray.append(AlbumModel(imageAlbomData: "heart.fill"))
        imageCollectionArray.append(AlbumModel(imageAlbomData: "heart.fill"))
        imageCollectionArray.append(AlbumModel(imageAlbomData: "heart.fill"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSegmentVC" {
            if let vc = segue.destination as? SegmetCollectionViewController {
                let album = sender as? [AlbumModel]
                print(album ?? "nil")
                vc.imageCollectionArray = album!
            }
        }
    }
}




extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = imageCollectionArray
        
        self.performSegue(withIdentifier: "showSegmentVC", sender: album)
    }
    
}
