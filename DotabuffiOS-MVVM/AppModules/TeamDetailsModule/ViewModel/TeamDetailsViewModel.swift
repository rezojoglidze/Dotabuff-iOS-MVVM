//
//  TeamDetailsViewModel.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/23/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct TeamDetailsItem {
    let title: String
    let description: String
}

protocol TeamDetailsViewModelDelegate: class {
    func didGetTeamDetails(teamDetails: [TeamDetailsItem])
    func didGetApiCallError()
}

class TeamDetailsViewModel {
    
    weak var delegate: TeamDetailsViewModelDelegate?
    
    private func secondsToTimeString(seconds : Int) -> String{
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    private func configureTeamDetailItems(teamDetails: TeamDetails) {
        let teamDetailsItems = [
            TeamDetailsItem(title: "სახელი", description: teamDetails.name),
            TeamDetailsItem(title: "ბოლო მატჩი", description: secondsToTimeString(seconds: teamDetails.lastMatchTime)),
            TeamDetailsItem(title: "რეიტინგი", description: String(teamDetails.rating)),
            TeamDetailsItem(title: "მოგების რაოდენობა", description: String(teamDetails.wins)),
            TeamDetailsItem(title: "წაგების რაოდენობა", description: String(teamDetails.losses))
        ]
        self.delegate?.didGetTeamDetails(teamDetails: teamDetailsItems)
    }
    
    func getTeamDetails(teamId: Int) {
        BaseAPI.shared.getTeamDetails(teamId: teamId) {[weak self] (response) in
            switch response {
            case .success(let teamDetails):
                self?.configureTeamDetailItems(teamDetails: teamDetails)
            case .failure( _):
                self?.delegate?.didGetApiCallError()
            }
        }
    }
}
