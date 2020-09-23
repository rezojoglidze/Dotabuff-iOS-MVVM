//
//  MatchDetailsViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/23/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

protocol MatchDetailsViewModelDelegate: class {
    func didGetMatchDetails(matchDetails: MatchDetails)
    func didGetApiCallError()
    func didGetTeamIdForDetails(teamId: Int)
}

class MatchDetailsViewModel {
    private var matchDetails: MatchDetails?
    weak var delegate: MatchDetailsViewModelDelegate?
    
    func getMatchDetails(matchId: Int) {
        BaseAPI.shared.getMatchDetails(matchId: matchId) { [weak self] (result) in
            
            switch result {
            case .success(let matchDetails):
                self?.matchDetails = matchDetails
                self?.delegate?.didGetMatchDetails(matchDetails: matchDetails)
            case .failure( _):
                self?.delegate?.didGetApiCallError()
            }
        }
    }
    
     func getRadianTeamIdForDetails() {
           if let radianTeam = matchDetails?.radiantTeam {
               delegate?.didGetTeamIdForDetails(teamId: radianTeam.teamId)
           }
       }
    
    func getDireTeamIdForDetails() {
          if let direTeam = matchDetails?.direTeam {
              delegate?.didGetTeamIdForDetails(teamId: direTeam.teamId)
          }
      }
}
