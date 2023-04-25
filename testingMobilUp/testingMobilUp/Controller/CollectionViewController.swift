//
//  CollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit

class CollectionViewController: UIViewController {
   
    
    @IBOutlet weak var albumCollection: UICollectionView!
    
    var albomDataImageArray:[AlbumModel] = []
    var arrUrlImage: [String?] = []
    var request: AlbumRequestModelProtocol = AlbomRequest(owner_id: "-128666765",
                                                          album_id: "266310117",
                                                          access_token: "vk1.a.6mTzFI_5fGKa77r2adPyV4c0L2zRpDVzUnc_uagJV-Z9s1Cf8q0mCpGbwEtojsLTg9mXUedQz1WY3rXbKQmp6cd0d0chGR8b5zClgkMnv0_3iEGw9Z7rCphhrPnn0I3PkHbJX-Q-7tfKd7YDTQOyQjSwR_a_-rGmlDIO6JhcGDhG2HG_pt3UUqzQcVMGfe9k")
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumCollection.dataSource = self
        self.albumCollection.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImage(token: "vk1.a.6mTzFI_5fGKa77r2adPyV4c0L2zRpDVzUnc_uagJV-Z9s1Cf8q0mCpGbwEtojsLTg9mXUedQz1WY3rXbKQmp6cd0d0chGR8b5zClgkMnv0_3iEGw9Z7rCphhrPnn0I3PkHbJX-Q-7tfKd7YDTQOyQjSwR_a_-rGmlDIO6JhcGDhG2HG_pt3UUqzQcVMGfe9k")
        
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
    
    //MARK:  работа с сетью
    // парсинг ответа вк
  private func getImage (token: String) {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "api.vk.com"
        urlComp.path = "/method/photos.get"
        
        urlComp.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "owner_id", value: "-128666765"),
            URLQueryItem(name: "album_id", value: "266310117"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let urlRequest = URLRequest(url: urlComp.url!)
        URLSession.shared.dataTask(with: urlRequest) { data , response , error in
        if let error = error {
            print("error")
            //alert
            return
        }
        guard let data = data else { return }
        
        do {
           let arrJs = try? JSONDecoder().decode(Albums.self, from: data)
            let arrItems = arrJs?.response.items
            let count = arrItems?.count
            
            // добираемся до url и добавляем в массив
            guard let count = count else { return }
            for i in 0..<count {
                
                let item = arrItems![i]   // 30 items
                let image = item
                let urlImage = image.sizes
                let arrImageUrl = urlImage.last
                let imageUrl = arrImageUrl?.url
                self.arrUrlImage.append(imageUrl)
            }
            self.loadImage()
        } catch {
            print(error) //alert
        }
        
        } .resume()
        
    }
    
    private func loadImage() {
        
        let api = arrUrlImage
        let session = URLSession(configuration: .default)
        
        for i in api {
            guard let url = URL(string: i!) else {
                return //alert
            }
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data, error == nil else {
                    return
                }
                let photoModel = AlbumModel(imageAlbomData: data)
                self.albomDataImageArray.append(photoModel)
                
            }
            task.resume()
            
        }
        self.albumCollection.reloadData()
    }
    
    
    
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albomDataImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? CollectionViewCell {
            itemCell.album = albomDataImageArray[indexPath.row]
            return itemCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albomDataImageArray
        
        self.performSegue(withIdentifier: "showSegmentVC", sender: album)
    }
    
}
 
