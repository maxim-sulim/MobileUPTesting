//
//  ImageViewModel.swift
//  testingMobileUp
//
//  Created by Максим Сулим on 25.04.2023.
//

import Foundation

class ImageViewModel {
    
    var arrUrlImage: [String?] = []
    
    func getImage (token: String) {
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
            
            
            guard let count = count else { return }
            for i in 0..<count {
                
                let item = arrItems![i]   // 30 items
                let image = item
                let urlImage = image.sizes
                let arrImageUrl = urlImage.last
                let imageUrl = arrImageUrl?.url
                self.arrUrlImage.append(imageUrl)
                
            }
            print(arrJs?.response.items)
        } catch {
            print(error)
        }
        
        } .resume()
        
    }
    
}

