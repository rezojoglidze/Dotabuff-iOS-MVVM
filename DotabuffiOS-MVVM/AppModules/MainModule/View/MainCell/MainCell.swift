//
//  MainCell.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    //MARK: Class Variables
    @IBOutlet weak var matcheIDLbl: UILabel!
    
    //MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = UIImageView(image: #imageLiteral(resourceName: "arrowRightIcon"))
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
            }) { (finished) in
                UIView.animate(withDuration: 0.15,delay: 0,options: .curveEaseInOut, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
    
    //MARK: View Setup
    func configure(with matcheId: Int) {
        self.matcheIDLbl.text = String(matcheId)
    }
}

