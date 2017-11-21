//
//  MomentList.swift
//  Cat
//
//  Created by Shuwen Li on 21/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

struct MomentList: Codable {
    let moments: [Moment]
}

struct Moment: Codable {
    let avatar: Avatar
    let cat: String
    let id: String
    let message: String
    let timestamp: String
    let thumbs: Thumbs
    
    struct Avatar: Codable {
        let image: String
    }
    struct Thumbs: Codable {
        let image: String
    }
}
