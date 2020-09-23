//
//  MainViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func didGetUserData(matchesIds: [Int])
    func didGetMatchIdForDetails(matchId: Int)
}

final class MainViewModel {
    
    //MARK: Class variable
    weak var delegate: MainViewModelDelegate?
    private var matchesIds: [Int] = []
    
    
    // Inputs
    func ready() {
        self.matchesIds = [ 5620275364, 271145478, 5619999390, 5620013443, 5619991492, 5619992102 ]
        delegate?.didGetUserData(matchesIds: matchesIds)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if matchesIds.isEmpty { return }
        delegate?.didGetMatchIdForDetails(matchId: matchesIds[indexPath.row])
    }
}
