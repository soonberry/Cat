//
//  HomeViewModel.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

let cellModel = HomeCellModel(
    cat: "Miao",
    message: "Miao miao",
    timestamp: "2017-10-23T02:18:33:238z"
)

let mockModels = [cellModel, cellModel]

class HomeViewModel {
    var homeModels: [HomeCellModel] = mockModels
    
    var count: Int {
        get {
            return homeModels.count
        }
    }
    func getCellViewModel(index: Int) -> HomeCellViewModel {
        return HomeCellViewModel(model: homeModels[index])
    }
}
