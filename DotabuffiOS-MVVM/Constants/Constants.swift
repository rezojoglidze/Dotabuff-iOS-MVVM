//
//  Constants.swift
//  Covid19
//
//  Created by Rezo Joglidze on 9/9/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Colors {
        static let main: UIColor = #colorLiteral(red: 0.5162952542, green: 0.4901071191, blue: 0.9351488948, alpha: 1)
    }

    struct Api {
        static let baseUrl = "https://api.opendota.com"
        
        struct Routes {
            static let api = "/api"
            static let matches = "/matches"
            static let teams = "/teams"
        }
    }
}
