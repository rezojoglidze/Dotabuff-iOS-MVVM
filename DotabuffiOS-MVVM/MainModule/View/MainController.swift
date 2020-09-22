//
//  ViewController.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/22/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
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
        configureContainerView()
        setupViewModel()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.ready()
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
    
    private func setupViewModel() {
        viewModel = MainViewModel()
        
        viewModel.isFirstLoaded = { [weak self] matchesIds in
            self?.matchesIds = matchesIds
            self?.tableView.reloadData()
            print("matchesIds -> \(matchesIds)")
        }
        
        viewModel.didSelecteMatch = { [weak self] id in
            let alertController = UIAlertController(title: "\(id)", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self?.present(alertController, animated: true, completion: nil)
            print("id -> \(id)")
        }
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
