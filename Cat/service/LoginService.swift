//
//  LoginService.swift
//  Cat
//
//  Created by Shuwen Li on 01/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class LoginService {
    
    private let urlSessionConfiguration = URLSessionConfiguration.default
    private let urlLogin = URL(string: "http://localhost:8080/catnip/login/")?.absoluteURL
    private let loginCredentialTranslator = LoginCredentialTranslator()
    private let loginKeyTranslator = LoginKeyTranslator()
    private let apiErrorTranslator = APIErrorTranslator()
    
    func performLogin(credential: LoginCredential, success: @escaping (LoginKey) -> Void, failure: @escaping (APIError) -> Void) {
       let session = URLSession(configuration: urlSessionConfiguration)
        
        var request = URLRequest(url: urlLogin!)
        request.httpMethod = "POST"
        request.httpBody = loginCredentialTranslator.translate(credential: credential)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let key = data.flatMap(self.loginKeyTranslator.translate) {
                success(key)
            }
            else {
                let err = self.apiErrorTranslator.translate(data: data, error: error)
                failure(err)
            }
        }
        task.resume()
        
    }
}
