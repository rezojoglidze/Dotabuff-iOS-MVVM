//
//  MainViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func didGetMatchesIds(matchesIds: [Int])
    func didGetMatchIdForDetailsView(matchId: Int)
}

final class MainViewModel {
    
    //MARK: Class variable
    weak var delegate: MainViewModelDelegate?
    private var matchesIds: [Int] = []
    
    
    func loadView() {
        self.matchesIds = [ 5620275364, 271145478, 5619999390, 5620013443, 5619991492, 5619992102 ]
        delegate?.didGetMatchesIds(matchesIds: matchesIds)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if matchesIds.isEmpty { return }
        delegate?.didGetMatchIdForDetailsView(matchId: matchesIds[indexPath.row])
    }
}
