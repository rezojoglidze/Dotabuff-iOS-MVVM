//
//  ViewController.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit

class MainController: HomeViewController {
    
    //MARK: Class variable
    private var matchesIds: [Int] = []
    private lazy var viewModel = MainViewModel()
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!


    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigaton()
        setupTableView()
        setUpViewModel()
        configureContainerView()
    }
    
    override func viewWillLayoutSubviews() {
        view.layoutIfNeeded()
        containerHeightConstraint.constant = tableView.contentSize.height
    }
    
    //MARK: View Setup
    func setupNavigaton() {
        navigationItem.title = "მთავარი"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4392156863, green: 0.3882352941, blue: 0.9176470588, alpha: 1)
    }
    
    func setUpViewModel(){
        viewModel.delegate = self
        viewModel.loadView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        tableView.estimatedRowHeight = 58
    }
    
    func configureContainerView() {
        containerView.layer.shadowOffset = CGSize(width: 0, height: 12)
        containerView.layer.shadowRadius = 35
        containerView.layer.shadowOpacity = 0.1
    }
    
    //MARK: navigation
    func showMatchDetailsView(matchId: Int) {
        let storyboard = UIStoryboard(name: "MatchDetails", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MatchDetailsIdentifier") as! MatchDetailsController
        controller.matchId = matchId
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension MainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchesIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.configure(with : matchesIds[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.setSelected(false, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension MainController: MainViewModelDelegate {
    func didGetMatchesIds(matchesIds: [Int]) {
        self.matchesIds = matchesIds
    }
    
    //MARK: navigation
    func didGetMatchIdForDetailsView(matchId: Int) {
      showMatchDetailsView(matchId: matchId)
    }
}
