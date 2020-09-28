//
//  MainViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func didGetMatchIdForDetailsView(matchId: Int)
}

class MainViewModel {
    
    //MARK: Class variable
    weak var delegate: MainViewModelDelegate?
    var matchesIds: [Int] = [ 5620275364, 271145478, 5619999390, 5620013443, 5619991492, 5619992102 ]
    
    func didSelectRow(at indexPath: IndexPath) {
        if matchesIds.isEmpty { return }
        delegate?.didGetMatchIdForDetailsView(matchId: matchesIds[indexPath.row])
    }
}
