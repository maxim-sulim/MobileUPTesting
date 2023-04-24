//
//  CollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit

class CollectionViewController: UIViewController {
   
    var get = ImageViewModel()
    
    @IBOutlet weak var albumCollection: UICollectionView!
    
    var imageCollectionArray:[AlbumModel] = []
    var result = InfoImage(widthImage: 0, heightImage: 0, urlImage: "")
    
    var request: AlbumRequestModelProtocol = AlbomRequest(owner_id: "-128666765",
                                                          album_id: "266310117",
                                                          access_token: "vk1.a.6mTzFI_5fGKa77r2adPyV4c0L2zRpDVzUnc_uagJV-Z9s1Cf8q0mCpGbwEtojsLTg9mXUedQz1WY3rXbKQmp6cd0d0chGR8b5zClgkMnv0_3iEGw9Z7rCphhrPnn0I3PkHbJX-Q-7tfKd7YDTQOyQjSwR_a_-rGmlDIO6JhcGDhG2HG_pt3UUqzQcVMGfe9k")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImageCollection()
        self.albumCollection.dataSource = self
        self.albumCollection.delegate = self
        //requestAlbum()
        get.getImage(token: "vk1.a.6mTzFI_5fGKa77r2adPyV4c0L2zRpDVzUnc_uagJV-Z9s1Cf8q0mCpGbwEtojsLTg9mXUedQz1WY3rXbKQmp6cd0d0chGR8b5zClgkMnv0_3iEGw9Z7rCphhrPnn0I3PkHbJX-Q-7tfKd7YDTQOyQjSwR_a_-rGmlDIO6JhcGDhG2HG_pt3UUqzQcVMGfe9k") { imag in
            self.result = imag}
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
    
/*
    private func requestAlbum () {
    var urlComp = URLComponents()
        //https://api.vk.com/method/photos.get
        
        urlComp.scheme = "https"
        urlComp.host = "api.vk.com"
        urlComp.path = "/method/photos.get"

        urlComp.queryItems = [
            URLQueryItem(name: "access_token", value: request.access_token),
            URLQueryItem(name: "owner_id", value: request.owner_id),
            URLQueryItem(name: "album_id", value: request.album_id )
        ]
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlComp.url!) {(data, request, error) in
            guard let data = data, error == nil else { return }
            print(data)
            print(error)
            DispatchQueue.main.async {
                let urlRequest = URLRequest(url: urlComp.url!)
                print(data)
            }
        }
        task.resume()
    }
    */
    
}


extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageCollectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? CollectionViewCell {
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
 
