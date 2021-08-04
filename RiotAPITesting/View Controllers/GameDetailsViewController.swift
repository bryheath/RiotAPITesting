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

    
    var matchData: MatchData!
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
        for participant in 0..<matchData.match.participantsInfo.count {
            //                print("\(game.match.participants[6].player.summonerName)")
            //                print("\(game.match.participantsInfo[6].teamId)")
            let teamID = matchData.match.participantsInfo[participant].teamId
            
            if teamID == 100 {
                blueTeamKills += matchData.match.participantsInfo[participant].stats.kills
                blueTeamDeaths += matchData.match.participantsInfo[participant].stats.deaths
                blueTeamAssists += matchData.match.participantsInfo[participant].stats.assists
            } else {
                redTeamKills += matchData.match.participantsInfo[participant].stats.kills
                redTeamDeaths += matchData.match.participantsInfo[participant].stats.deaths
                redTeamAssists += matchData.match.participantsInfo[participant].stats.assists
            }
            
        }
    }
    
    func setupTeamCell(index: IndexPath) -> TeamTableViewCell {
        let team = matchData.match.teamsInfo[index.section]
        var teamColor = ""
        let winString = team.win ? "Win" : "Loss"

        let teamCell: TeamTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "teamCell", for: index) as! TeamTableViewCell
        
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
        teamCell.rightLabel.text = "\(team.baronKills)B \(team.dragonKills)D \(team.towerKills)T"
        return teamCell
    }
   
    func setupPlayerCell(index: IndexPath) -> PlayerTableViewCell {
        let playerCell: PlayerTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "playerCell", for: index) as! PlayerTableViewCell
        var participantIndex = 0
        participantIndex += index.row - 1
        if index.section == 1 {
            participantIndex += 5
        }
        
        let matchParticipant = matchData.match.participantsInfo[participantIndex]
        let championId = matchParticipant.championId
        let championName = championJSONNames[championId.value]!
        
        if let image = UIImage(named: championName) {
            playerCell.championImageView.image = image
        }
        
        playerCell.setSummonerSpellsForCell(participant: matchParticipant)
        
        playerCell.setRunePathImages(stats: matchParticipant.stats)
//        getRunePathImage(runePathId: matchParticipant.stats.primaryRunePath!) { image in playerCell.primaryRuneImageView.setImage(image) }
//        getRunePathImage(runePathId: matchParticipant.stats.secondaryRunePath!) { image in playerCell.secondaryRuneImageView.setImage(image) }
        
        playerCell.playerNameLabel.text = matchData.match.participants[participantIndex].player.summonerName
        
        playerCell.setKDAForCell(stats: matchParticipant.stats)
        playerCell.setCSAndGoldLabel(matchData: matchData)
        
        var imagesDict = [Int: UIImage]()
        let stats = matchParticipant.stats
        let itemIDArray = [stats.item0, stats.item1, stats.item2, stats.item3, stats.item4, stats.item5, stats.item6]
        let itemImageViewArray = [playerCell.item0ImageView, playerCell.item1ImageView, playerCell.item2ImageView, playerCell.item3ImageView, playerCell.item4ImageView, playerCell.item5ImageView, playerCell.item6ImageView]
        
        for item in 0..<itemIDArray.count {
            getItemImage(itemId: itemIDArray[item]) { image in
                imagesDict[item] = image
                if let itemImage = itemImageViewArray[item] {
                    itemImage.setImage(imagesDict[item])
                }
            }
        }
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
            victoryLabel.text = matchData.victory ? "Win" : "Loss"
                
            let currentTime = Date()
            let difference = Calendar.current.dateComponents([.hour, .minute], from: matchData.gameCreation, to: currentTime)
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
            modeTimeDurationLabel.text = "\(matchData.gameMode) | \(sinceGame) | \(matchData.gameDurationMinutes):\(matchData.gameDurationSeconds)"
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
