//
//  BannerService.swift
//  Cat
//
//  Created by Shuwen Li on 07/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation
import UIKit

class BannerService {
    
    private let urlSessionConfiguration = URLSessionConfiguration.default
    private let urlAppearance = URL(string: "http://localhost:8080/catnip/image/banner1.jpg")
     private let apiErrorTranslator = APIErrorTranslator()
    
    func getBanner(success: @escaping (_ bannerImage: UIImage) -> Void, failure: @escaping (APIError) -> Void) {
        let session = URLSession(configuration: urlSessionConfiguration)
        
        var request = URLRequest(url: urlAppearance!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let imageData = data {
                DispatchQueue.main.async {
                    success(UIImage(data: imageData)!)
                }
            }
            else {
                let err = self.apiErrorTranslator.translate(data: data, error: error)
                failure(err)
            }
        }
        task.resume()
        
    }
}
