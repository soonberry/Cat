//
//  HomeCellViewModel.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation
import Kingfisher

class HomeCellViewModel {
    let prefix = "http://localhost:8080/catnip"
    var model: Moment
    
    init(model: Moment) {
        self.model = model
    }
    
    var cat:String {
        get {
            return model.cat
        }
    }
    var message: String {
        get {
            return model.message
        }
    }
    
    var time: String {
        get {
            return model.timestamp
        }
    }
    var avatar: URL {
        get {
            return URL(string: prefix + model.avatar.image)!
        }
    }
    
    var thumbs: [URL] {
        get {
            var url: [URL] = []
            for imageURL in model.thumbs {
                url.append(URL(string: prefix + imageURL.image)!)
            }
            return url
        }
    }
    
}
