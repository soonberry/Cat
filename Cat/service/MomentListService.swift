//
//  CatService.swift
//  Cat
//
//  Created by Shuwen Li on 20/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class MomentListService {
    private let urlSessionConfiguration = URLSessionConfiguration.default
    private let urlAppearance = URL(string: "http://localhost:8080/catnip/moment/")
    private let apiErrorTranslator = APIErrorTranslator()
    private let decoder = JSONDecoder()
    
    func getMomentList(success: @escaping (_ moment: [Moment]) -> Void, failure: @escaping (APIError) -> Void) {
        let session = URLSession(configuration: urlSessionConfiguration)
        
        var request = URLRequest(url: urlAppearance!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let momentData = data else {
                let err = self.apiErrorTranslator.translate(data: data, error: error)
                failure(err)
                return
            }
            let momentList = try? self.decoder.decode(MomentList.self, from: momentData)
            DispatchQueue.main.async {
                success(momentList!.moments)
            }
        }
        task.resume()
    }
    
}
