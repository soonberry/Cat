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
    private let urlAppearance = URL(string: "http://localhost:8080/catnip/appearance/")
    private let apiErrorTranslator = APIErrorTranslator()
    private let decoder = JSONDecoder()
    
    func getBanner(success: @escaping (_ bannerImages: [CatImage]) -> Void, failure: @escaping (APIError) -> Void) {
        let session = URLSession(configuration: urlSessionConfiguration)
        
        var request = URLRequest(url: urlAppearance!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let imageData = data else {
                let err = self.apiErrorTranslator.translate(data: data, error: error)
                failure(err)
                return
            }
            let bannerList = try? self.decoder.decode(BannerList.self, from: imageData)
            DispatchQueue.main.async {
                success(bannerList!.banners)
            }
        }
        task.resume()
    }
    
    static func getBanner() -> Procedure<[CatImage]> {
        return Procedure<[CatImage]>({ (completion) in
            BannerService().getBanner(success: { (images) in
                completion(Result.success(value: images))
            }, failure: { (error) in
                completion(Result.fail(errorMessage: error.message))
            })
        })
    }
    
}
