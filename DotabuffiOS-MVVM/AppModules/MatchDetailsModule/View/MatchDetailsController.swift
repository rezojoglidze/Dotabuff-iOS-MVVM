//
//  MatchDetailsController.swift
//  DotabuffiOS-MVVM
//
//  Created by Rezo Joglidze on 9/23/20.
//  Copyright © 2020 Rezo Joglidze. All rights reserved.
//

import UIKit
import Kingfisher

class MatchDetailsController: UIViewController {
    //MARK: Class variable
    private var matchDetails: MatchDetails!
    private lazy var viewModel = MatchDetailsViewModel()
    var matchId: Int?
    
    //MARK: IBOutlet
    @IBOutlet weak var winnerTeamImg: UIImageView!
    @IBOutlet weak var winnerTeamLbl: UILabel!
    @IBOutlet weak var radiantImg: UIImageView!
    @IBOutlet weak var direImg: UIImageView!
    @IBOutlet weak var radiantBtn: UIButton!
    @IBOutlet weak var direBtn: UIButton!
    @IBOutlet weak var radiantScoreLbl: UILabel!
    @IBOutlet weak var matchDurationLbl: UILabel!
    @IBOutlet weak var direScoreLbl: UILabel!
    @IBOutlet weak var gameModeLbl: UILabel!
    @IBOutlet weak var firstBloodTimeLbl: UILabel!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setupNavigaton()
        addTargetToBtns()
    }
    
    func addTargetToBtns() {
        radiantBtn.addTarget(self, action: #selector(handleRadiantTeam), for: .touchUpInside)
        direBtn.addTarget(self, action: #selector(handleDireTeam), for: .touchUpInside)
        
        let radianTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleRadiantTeam))
        radiantImg.addGestureRecognizer(radianTapGestureRecognizer)
        
        let dareTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDireTeam))
        direImg.addGestureRecognizer(dareTapGestureRecognizer)
    }
    
    @objc func handleRadiantTeam(){
        viewModel.getRadianTeamIdForDetails()
    }
    
    @objc func handleDireTeam(){
        viewModel.getDireTeamIdForDetails()
    }
    
    
    //MARK: View Setup
    func setupNavigaton() {
        navigationItem.title = "მატჩის დეტალები"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4392156863, green: 0.3882352941, blue: 0.9176470588, alpha: 1)
    }
    
    func configureView() {
        self.startLoading()
        viewModel.delegate = self
        if let matchId = matchId {
            viewModel.getMatchDetails(matchId: matchId)
        }
    }
    
    func secondsToTimeString(seconds : Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(seconds))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    func loadImageView(url: String, img: UIImageView) {
        img.kf.setImage(with: URL(string: url))
        if img == winnerTeamImg {
            img.isHidden = false
            img.shake(translationX: 20, y: 0)
        }
    }
    
    func configureWinnerTeamLbl(with matchDetails: MatchDetails) {
        if matchDetails.radiantWin {
            winnerTeamLbl.text = "RADIANT VICTORY"
            winnerTeamLbl.textColor = #colorLiteral(red: 0.5725490196, green: 0.6470588235, blue: 0.1450980392, alpha: 1)
            if let url =  matchDetails.radiantTeam?.logoUrl {
                loadImageView(url: url, img: winnerTeamImg)
            }
        } else {
            winnerTeamLbl.text = "DIRE VICTORY"
            winnerTeamLbl.textColor = #colorLiteral(red: 0.7607843137, green: 0.2352941176, blue: 0.1647058824, alpha: 1)
            if let url =  matchDetails.direTeam?.logoUrl {
                loadImageView(url: url, img: winnerTeamImg)
            }
        }
    }
    
    func configureTeamsBtns(with matchDetails: MatchDetails) {
        if let direTeam = matchDetails.direTeam {
            direBtn.isEnabled = true
            if let url = direTeam.logoUrl {
                self.loadImageView(url: url, img: direImg)
                self.direImg.isHidden = false
            }
        }
        
        if let radianTeam = matchDetails.radiantTeam {
            radiantBtn.isEnabled = true
            if let url = radianTeam.logoUrl {
                loadImageView(url: url, img: radiantImg)
                radiantImg.isHidden = false
            }
        }
    }
    
    func configureScoreView(with matchDetails: MatchDetails) {
        radiantScoreLbl.text = String(matchDetails.radiantScore)
        direScoreLbl.text = String(matchDetails.direScore)
        matchDurationLbl.text = secondsToTimeString(seconds: matchDetails.duration)
        firstBloodTimeLbl.text = secondsToTimeString(seconds: matchDetails.firstBloodTime)
        if let name = getGameModeName(id: matchDetails.gameMode) {
            gameModeLbl.text = name
        }
    }
    
    func getGameModeName(id: Int) -> String? {
        if let url = Bundle.main.url(forResource: "GameModes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let gameModes = try JSONDecoder().decode([Int: GameMode].self, from: data)
                return gameModes[id]?.name
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func showApiCallErrorAlert() {
        let alert = UIAlertController(title: nil, message: "სამწუხაროდ, მოხდა შეფერხება. სცადეთ მოგვიანებით.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showTeamDetails(teamId: Int) {
        let storyboard = UIStoryboard(name: "TeamDetails", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TeamDetailsIdentifier") as! TeamDetailsController
        controller.teamId = teamId
        controller.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MatchDetailsController: MatchDetailsViewModelDelegate {
    func didGetMatchDetails(matchDetails: MatchDetails) {
        self.stopLoading()
        self.matchDetails = matchDetails
        configureWinnerTeamLbl(with: matchDetails)
        configureTeamsBtns(with: matchDetails)
        configureScoreView(with: matchDetails)
    }
    
    func didGetApiCallError() {
        showApiCallErrorAlert()
    }
    
    //MARK: Navigation
    func didGetTeamIdForDetails(teamId: Int) {
        showTeamDetails(teamId: teamId)
    }
}
