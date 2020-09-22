//
//  Extensions.swift
//  WeatheriOS
//
//  Created by Rezo Joglidze on 9/15/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    enum HelveticaNeueGeo: String {
        case medium = "HelveticaNeueLTGEO-65Medium"
        case roman = "HelveticaNeueLTGEO-55Roman"
        case bold = "HelveticaNeueLTGEO-75Bold"
    }
    
    static func main(type: HelveticaNeueGeo, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
