//
//  MatchDetails.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct MatchDetails: Codable {
    let duration: Int
    let gameMode: Int
    let radiantWin: Bool
    let firstBloodTime: Int
    let radiantScore: Int
    let direScore: Int
    let direTeam: Team?
    let radiantTeam: Team?

    enum CodingKeys: String, CodingKey {
        case gameMode = "game_mode"
        case radiantWin = "radiant_win"
        case firstBloodTime = "first_blood_time"
        case radiantScore = "radiant_score"
        case direScore = "dire_score"
        case direTeam = "dire_team"
        case radiantTeam = "radiant_team"
        case duration
    }
}

struct Team: Codable {
    let teamId: Int
    let name: String
    let tag: String
    let logoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case teamId = "team_id"
        case logoUrl = "logo_url"
        case name, tag
    }
}

