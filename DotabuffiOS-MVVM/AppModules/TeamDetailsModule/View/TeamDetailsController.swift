//
//  TeamDetailsController.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/23/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit

class TeamDetailsController: UIViewController {
    
    //MARK: Class variable
    private var teamDetails: [TeamDetailsItem] = []
    private lazy var viewModel = TeamDetailsViewModel()
    var teamId: Int?

    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupNavigaton()
        setupTableView()
    }
    
    //MARK: View Setup
    private func configureView() {
        self.startLoading()
        viewModel.delegate = self
        if let teamId = teamId {
            viewModel.getTeamDetails(teamId: teamId)
        }
    }
    
   private func setupNavigaton() {
        navigationItem.title = "გუნდის დეტალები"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TeamDetailsCell", bundle: nil), forCellReuseIdentifier: "TeamDetailsCell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
    }
    
    private func showApiCallErrorAlert() {
        let alert = UIAlertController(title: nil, message: "სამწუხაროდ, მოხდა შეფერხება. სცადეთ მოგვიანებით.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}


extension TeamDetailsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamDetailsCell", for: indexPath) as! TeamDetailsCell
        cell.configure(with : teamDetails[indexPath.row])
        return cell
    }
}

extension TeamDetailsController: TeamDetailsViewModelDelegate {
    func didGetTeamDetails(teamDetails: [TeamDetailsItem]) {
        self.stopLoading()
        self.teamDetails = teamDetails
        tableView.reloadData()
    }
    
    func didGetApiCallError() {
        showApiCallErrorAlert()
    }
}
