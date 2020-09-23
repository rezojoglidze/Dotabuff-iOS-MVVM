//
//  HomeViewController.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.main(type: .bold, size: 15)]
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
