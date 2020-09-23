//
//  TeamDetails.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct TeamDetails: Codable {
    let lastMatchTime: Int
    let logoUrl: String
    let losses: Int
    let name: String
    let rating: Double
    let tag: String
    let teamId: Int
    let wins: Int

    enum CodingKeys: String, CodingKey {
        case lastMatchTime = "last_match_time"
        case logoUrl = "logo_url"
        case teamId = "team_id"
        case losses, name, rating, tag, wins
    }
}
