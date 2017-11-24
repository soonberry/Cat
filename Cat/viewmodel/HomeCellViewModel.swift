//
//  HomeCellViewModel.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class HomeCellViewModel {
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

    
}
