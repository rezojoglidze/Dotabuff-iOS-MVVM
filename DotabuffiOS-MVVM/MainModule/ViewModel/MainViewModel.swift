//
//  MainViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

final class MainViewModel {
    
    //MARK: Class variable
    private var matchesIds: [Int] = [Int] () {
        didSet {
            isFirstLoaded?(matchesIds)
        }
    }
    
    var isFirstLoaded: (([Int]) -> Void)?
    var didSelecteMatch: ((Int) -> Void)?
    
    
    // Inputs
    func ready() {
        self.matchesIds = [ 5620275364, 271145478, 5619999390, 5620013443, 5619991492, 5619992102 ]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if matchesIds.isEmpty { return }
        didSelecteMatch?(matchesIds[indexPath.item])
    }
}
