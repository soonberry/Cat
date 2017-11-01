//
//  LoginViewModel.swift
//  Cat
//
//  Created by Shuwen Li on 01/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class LoginViewModel {
    var loginError: APIError?
    
    var loginErrorMessage: String? {
        return loginError?.message
    }
}
