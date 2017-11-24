//
//  HomeViewModel.swift
//  Cat
//
//  Created by Shuwen Li on 25/10/2017.
//  Copyright © 2017 Shuwen Li. All rights reserved.
//

import Foundation

class HomeViewModel {
    var homeModels: [Moment] = []
    
    func setMoments(momentList: [Moment]) {
        self.homeModels = momentList
    }
    
    var count: Int {
        get {
            return homeModels.count
        }
    }
    func getCellViewModel(index: Int) -> HomeCellViewModel {
        return HomeCellViewModel(model: homeModels[index])
    }
}
