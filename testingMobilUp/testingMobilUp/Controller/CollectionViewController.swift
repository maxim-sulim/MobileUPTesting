//
//  CollectionViewController.swift
//  testingMobilUp
//
//  Created by Максим Сулим on 21.04.2023.
//

import UIKit
import WebKit
import Foundation

class CollectionViewController: UIViewController {
   
    private var storage: UserStorageProtocol = UserStorage()
    
    
    @IBAction func logout(_ sender: Any) {
        storage.removeAll()
        self.navigationController?.dismiss(animated: true)
    }
    @IBOutlet weak var albumCollection: UICollectionView!
    
    var offset: CGFloat = 2
    var countCells = 2
    var albomDataImageArray = [AlbumModel]()// храрение дейты и даты
    var arrUrlImage: [String?] = []
    var arrDateUnix: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albumCollection.dataSource = self
        self.albumCollection.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if albomDataImageArray.isEmpty {
            getImage()
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
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
    private func getImage () {
        
        let token = storage.load()
        let veryToken = token.token
        
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "api.vk.com"
        urlComp.path = "/method/photos.get"
        
        urlComp.queryItems = [
            URLQueryItem(name: "access_token", value: veryToken),
            URLQueryItem(name: "owner_id", value: "-128666765"),
            URLQueryItem(name: "album_id", value: "266310117"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let urlRequest = URLRequest(url: urlComp.url!)
        URLSession.shared.dataTask(with: urlRequest) { data , response , error in
            if error == nil {
                guard let data = data else {
                    return }
                do {
                    let arrJs = try? JSONDecoder().decode(Albums.self, from: data)
                    let arrItems = arrJs?.response.items
                    let count = arrItems?.count
                    
                    // добираемся до url, data и добавляем в массив
                    guard let count = count else { return }
                    for i in 0..<count {
                        
                        let item = arrItems![i]   // 30 items
                        let image = item
                        let urlImage = image.sizes
                        let data = image.date
                        self.arrDateUnix.append(data)
                        let arrImageUrl = urlImage.last
                        let imageUrl = arrImageUrl?.url
                        self.arrUrlImage.append(imageUrl)
                    }
                    self.loadImage()
                } catch {
                    self.outError()
                }
            } else {
                self.outError()
            }
        }.resume()
    }
    
    private func loadImage() {
        
        let api = arrUrlImage
        let session = URLSession(configuration: .default)
        var timer = 0
        for i in api {
            let arrUnix = arrDateUnix[timer]
            timer += 1
            guard let url = URL(string: i!) else {
                self.outError()
                return
            }
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data, error == nil else {
                    return
                }
                let date = Date.init(timeIntervalSinceReferenceDate: TimeInterval(Double(arrUnix/10000)))
                let model = AlbumModel(imageAlbomData: data, imageDateUnix: date)
                self.albomDataImageArray.append(model)
                DispatchQueue.main.async {
                    self.albumCollection.reloadData()
                }
            }
            task.resume()
        }
    }
    
    private func outError() {
        let error = UIAlertController(title: "Ошибка подключения", message: "Просите", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel)
        error.addAction(cancel)
        self.present(error, animated: true)
    }
    
}

//MARK: DATASOURSE DELEGATE

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameVC = collectionView.frame
        let widthCell = (frameVC.width / CGFloat(countCells)) - 2
        let heghtCell = widthCell
        let spasing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        
        return CGSize(width: widthCell - spasing, height: heghtCell - (offset*2))
    }
 
}
 
