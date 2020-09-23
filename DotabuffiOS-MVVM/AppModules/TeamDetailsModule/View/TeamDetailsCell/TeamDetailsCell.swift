//
//  TeamDetailsCell.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/23/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit

class TeamDetailsCell: UITableViewCell {
    //MARK: IBOutle
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    //MARK: View Setup
    func configure(with teamDetail: TeamDetailsItem) {
        self.title.text = teamDetail.title
        self.detail.text = teamDetail.description
    }
}
