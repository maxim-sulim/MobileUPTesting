//
//  ImageViewModel.swift
//  testingMobileUp
//
//  Created by Максим Сулим on 25.04.2023.
//

import Foundation
import Alamofire

class ImageViewModel {
    
    func getImage (token: String, complation: @escaping (InfoImage) -> ()) {
        let url = "https://api.vk.com/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": "-128666765",
            "album_id": "266310117",
            "v": "5.131",
        ]
        AF.request(url, method: .post, parameters: params).response { result in
            if let data = result.data {
                if let album = try? JSONDecoder().decode(InfoImage.self, from: data) {
                    complation(album)
                }
            }
        }
    }
    
    
}
