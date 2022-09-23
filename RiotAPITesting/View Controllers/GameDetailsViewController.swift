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
        
        var teamColor = ""
        var winString = ""
        if team.win {
            winString = "Win"
            teamCell.backgroundColor = UIColor.init(red: 0, green: 0.75, blue: 0, alpha: 1)
        } else {
            winString = "Loss"
            teamCell.backgroundColor = UIColor.init(red: 0.75, green: 0, blue: 0, alpha: 1)
        }
        
        
        teamCell.frame.size.height = 44
        if team.teamId == 100 {
            teamColor = "Blue"
            let kda:Double = Double((blueTeamKills+blueTeamAssists))/Double(blueTeamDeaths)
            let newKDA = formatter.string(for:kda)
            teamCell.leftLabel.text = "\(winString) (\(teamColor)) KDA - \(blueTeamKills) / \(blueTeamDeaths) / \(blueTeamAssists) -- \(newKDA!): 1"
            
        } else {
            teamColor = "Red"
            let kda:Double = Double((redTeamKills+redTeamAssists))/Double(redTeamDeaths)
            let newKDA = formatter.string(for: kda)
            teamCell.leftLabel.text = "\(winString) (\(teamColor)) KDA - \(redTeamKills) / \(redTeamDeaths) / \(redTeamAssists) -- \(newKDA!): 1"
        }
        teamCell.rightLabel.text = "\(baron.kills)B \(dragon.kills)D \(tower.kills)T \(inhibitor.kills)I"
        return teamCell
    }
   
    func setupPlayerCell(index: IndexPath) -> PlayerTableViewCell {
        let playerCell: PlayerTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: index) as! PlayerTableViewCell
        var participantIndex = 0
        participantIndex += index.row - 1
        if index.section == 1 {
            participantIndex += 5
        }
        let matchParticipant = matchData.info.participants[participantIndex]

        playerCell.setChampionImage(participant: matchParticipant)
        playerCell.setSummonerSpellsForCell(participant: matchParticipant)
        playerCell.setRunePathImages(participant: matchParticipant)
        playerCell.setPlayerNameLabel(summonerName: matchParticipant.summonerName)
        //playerCell.playerNameLabel.text = matchParticipant.summonerName
    
        playerCell.setKDAForCell(participant: matchParticipant)
        let duration = Duration(minutes: Double(matchData.info.gameDuration))
        playerCell.setCSAndGoldLabel(participant: matchParticipant, gameDuration: duration)
        //playerCell.setItemImages(matchData: matchData, index: participantIndex)

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
            //victoryLabel.text = matchData.you.win ? "Win" : "Loss"
                
            let currentTime = Date()
            //let gameEndTime = TimeInterval(matchData.info.gameCreation + matchData.info.gameDuration)
            let gameEnd = Date(timeIntervalSince1970: TimeInterval(matchData.info.gameEndTimestamp/1000))
            let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: gameEnd, to: currentTime)
            if let days = difference.day {
                sinceGame += "\(days)d ago"
            } else {
                
                if let hours = difference.hour {
                    sinceGame += "\(hours)h "
                }
                if let minutes = difference.minute {
                    sinceGame += "\(minutes)m ago"
                }
                
            }
            let duration = Duration(minutes: Double(matchData.info.gameDuration))
            modeTimeDurationLabel.text = "\(matchData.info.gameMode.mode.description) | \(sinceGame) | \(duration.minutes):\(duration.seconds)"
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
