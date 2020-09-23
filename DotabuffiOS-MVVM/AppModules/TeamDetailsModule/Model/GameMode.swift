//
//  GameMode.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct GameMode: Decodable {
    let id: Int
    let name: String
    let balanced: Bool?
}
