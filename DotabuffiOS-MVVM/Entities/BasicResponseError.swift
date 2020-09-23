//
//  BasicResponseError.swift
//  WeatheriOS
//
//  Created by Rezo Joglidze on 9/14/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation

struct BasicResponseError: Codable,Error {
    let code: Int
    let message: String
    
    init() {
        code = -1
        message = "მოხდა შეცდომა მონაცემების დამუშავებისას"
    }
}
