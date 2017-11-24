//
//  Moment.swift
//  Cat
//
//  Created by Shuwen Li on 23/11/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

struct Moment: Codable {
    let avatar: Avatar
    let cat: String
    let id: String
    let message: String
    let thumbs: [ThumbImage]
    let timestamp: String
}

struct Avatar: Codable {
    let image: String
}
struct ThumbImage: Codable {
    let image: String
}
