//
//  GameDetailsViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/1/21.
//

import Foundation
import LeagueAPI
class GameDetailsViewController: UIViewController {

    
    @IBOutlet var headerView: UIView!
    var matchData: Match!
    @IBOutlet var victoryLabel: UILabel!
    @IBOutlet var modeTimeDurationLabel: UILabel!
    var winLoss: Bool = true
    let formatter = NumberFormatter()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //@IBOutlet var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3

        if let matchData = matchData {
            //getTeamStats()
            var sinceGame = ""
            //victoryLabel.setText(matchData.you.win ? "WIN" : "LOSS")
            victoryLabel.setText(winLoss ? "VICTORY" : "LOSS")
            self.view.backgroundColor = winLoss ? winColor : lossColor
            self.headerView.backgroundColor = winLoss ? winColor : lossColor
                
            let currentTime = Date()
            //let gameEndTime = TimeInterval(matchData.info.gameCreation + matchData.info.gameDuration)
            let gameEnd = Date(timeIntervalSince1970: TimeInterval(matchData.info.gameEndTimestamp/1000))
            let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: gameEnd, to: currentTime)
            if let days = difference.day {
                if days >= 1 {
                    sinceGame += "\(days)d ago"
                } else {
                    if let hours = difference.hour {
                        sinceGame += "\(hours)h "
                    }
                    if let minutes = difference.minute {
                        sinceGame += "\(minutes)m ago"
                    }
                }
            } else {
                sinceGame = "N/A"
            }
            let duration:TimeInterval = Double(matchData.info.gameDuration)
            //let decimalGameDuration = Double(duration.minute) + (Double(duration.second) / 60.0)
            let queue = QueueMode(Long(matchData.info.queueId))
            let queueFormatted = formatQueue(mode: queue.mode.description)
            modeTimeDurationLabel.text = "\(queueFormatted) | \(sinceGame) | \(duration.minuteSecond)"
        }
        
    }
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Abstract Method
    //----------------------------------------------------------------
    
    static func viewController() -> GameDetailsViewController {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailsViewController") as! GameDetailsViewController
    }

    //=======
    // MARK: ViewControllers
    //=======
    
    private lazy var summaryViewController: GameDetailsSummaryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "GameDetailsSummaryController") as! GameDetailsSummaryViewController
        viewController.matchData = matchData
        self.add(asChildViewController: viewController)
        

        
        return viewController
    }()
    
    private lazy var statsViewController: GameDetailsStatsViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "GameDetailsStatsViewController") as! GameDetailsStatsViewController
        viewController.matchData = matchData
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        

        
        return viewController
    }()
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Action Methods
    //----------------------------------------------------------------
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    //----------------------------------------------------------------
    // MARK:-
    // MARK:- Custom Methods
    //----------------------------------------------------------------
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    //----------------------------------------------------------------
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    //----------------------------------------------------------------
    
    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: statsViewController)
            add(asChildViewController: summaryViewController)
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: statsViewController)
        }
    }
    
    //----------------------------------------------------------------
    
    func setupView() {
//        setupSegmentedControl()
        
        updateView()
    }
    
    /*func getTeamStats() {
        for participant in 0..<matchData.info.participants.count {
            
            //                print("\(game.match.participants[6].player.summonerName)")
            //                print("\(game.match.participantsInfo[6].teamId)")
            let players = matchData.info.participants
            let teamID = players[participant].teamId
            let stats = players[participant]
            
            if teamID == 100 {
                blueTeamKills += stats.kills
                blueTeamDeaths += stats.deaths
                blueTeamAssists += stats.assists
            } else {
                redTeamKills += stats.kills
                redTeamDeaths += stats.deaths
                redTeamAssists += stats.assists
            }
            
        }
    }*/
}
