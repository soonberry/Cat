//
//  LoginCredentialTranslate.swift
//  Cat
//
//  Created by Shuwen Li on 01/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class LoginCredentialTranslator {
    func translate(credential: LoginCredential) -> Data {
        let dict = [
            "username": credential.username,
            "password": credential.password
        ]
        
        return try! JSONSerialization.data(withJSONObject: dict, options: [])
    }
}
