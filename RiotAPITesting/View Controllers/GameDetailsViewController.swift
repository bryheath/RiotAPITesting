//
//  GameDetailsViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/1/21.
//

import Foundation
import LeagueAPI
class GameDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.setupTeamCell(index: indexPath)
        } else {
            return self.setupPlayerCell(index: indexPath)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    
    @IBOutlet var headerView: UIView!
    var matchData: Match!
    @IBOutlet var victoryLabel: UILabel!
    @IBOutlet var modeTimeDurationLabel: UILabel!
    @IBOutlet var SDBSegmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var blueTeamKills = 0
    var blueTeamDeaths = 0
    var blueTeamAssists = 0
    var redTeamKills = 0
    var redTeamDeaths = 0
    var redTeamAssists = 0
    let formatter = NumberFormatter()
    var winLoss: Bool = true
    
    func getTeamStats() {
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
    }
    
    func setupTeamCell(index: IndexPath) -> TeamTableViewCell {
        let teamCell: TeamTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "teamCell", for: index) as! TeamTableViewCell
        
        let team = matchData.info.teams[index.section]
        let objectives = team.objectives
        let baron = objectives.baron
        let dragon = objectives.dragon
        let tower = objectives.tower
        let inhibitor = objectives.inhibitor
        let herald = objectives.riftHerald
        
        var winString = ""
        if team.win {
            winString = "VICTORY"
            teamCell.backgroundColor = winColor //CC9900 Opacity 70%
        } else {
            winString = "LOSS"
            teamCell.backgroundColor = lossColor //990000 Opacity 70%
        }
        
        
        teamCell.frame.size.height = 44
        if team.teamId == 100 {
            teamCell.leftLabel.text = "\(winString)"
            teamCell.rightLabel.text = "\(blueTeamKills)/\(blueTeamDeaths)/\(blueTeamAssists)"
        } else {
            teamCell.leftLabel.text = "\(winString)"
            teamCell.rightLabel.text = "\(redTeamKills)/\(redTeamDeaths)/\(redTeamAssists)"
        }
        
        
        teamCell.dragonsKilled.text = "\(dragon.kills)"
        print(dragon.kills)
        teamCell.heraldsKilled.text = "\(herald.kills)"
        print(herald.kills)
        teamCell.baronsKilled.text = "\(baron.kills)"
        print(baron.kills)
        teamCell.inhibsDestroyed.text = "\(inhibitor.kills)"
        print(inhibitor.kills)
        teamCell.towersDestroyed.text = "\(tower.kills)"
        print(tower.kills)
        return teamCell
    }
   
    func setupPlayerCell(index: IndexPath) -> PlayerTableViewCell {
        let playerCell: PlayerTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: index) as! PlayerTableViewCell
        var participantIndex = 0
        participantIndex += index.row - 1
        if index.section == 1 {
            participantIndex += 5
            playerCell.backgroundColor = redTeamColor
        } else {
            playerCell.backgroundColor = blueTeamColor
        }
        let matchParticipant = matchData.info.participants[participantIndex]
        
        playerCell.setChampionImage(participant: matchParticipant)
        playerCell.setSummonerSpellsForCell(participant: matchParticipant)
        playerCell.setRunePathImages(participant: matchParticipant)
        playerCell.setPlayerNameLabel(summonerName: matchParticipant.summonerName)
        
        playerCell.setKDAForCell(participant: matchParticipant)
        let duration = Duration(minutes: Double(matchData.info.gameDuration))
        playerCell.setCSAndGoldLabel(participant: matchParticipant, gameDuration: duration)
        playerCell.setItemImages(participant: matchParticipant)

        return playerCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3

        if let matchData = matchData {
            getTeamStats()
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0) {
            return 44
        } else {
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0) {
            return 44
        } else {
            return 60
        }
    }
    
}
