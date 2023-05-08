//
//  GameDetailsStatsViewController.swift
//  RiotAPITesting
//
//  Created by Bryan on 5/8/23.
//  Copyright © 2023 Bryan Heath. All rights reserved.
//


//TODO: Make this work and be useful

import Foundation
import LeagueAPI

class GameDetailsStatsViewController: UITableViewController {
    var matchData: Match!

    
    override func viewDidLoad() {
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0) {
            return 44
        } else {
            return 60
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0) {
            return 44
        } else {
            return 60
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
        
//        var winString = ""
        if team.win {
  //          winString = "VICTORY"
            teamCell.backgroundColor = winColor //CC9900 Opacity 70%
        } else {
    //        winString = "LOSS"
            teamCell.backgroundColor = lossColor //990000 Opacity 70%
        }
        
        
        teamCell.frame.size.height = 44
        //May not need
//        if team.teamId == 100 {
//            teamCell.leftLabel.text = "\(winString)"
//            teamCell.rightLabel.text = "\(blueTeamKills)/\(blueTeamDeaths)/\(blueTeamAssists)"
//        } else {
//            teamCell.leftLabel.text = "\(winString)"
//            teamCell.rightLabel.text = "\(redTeamKills)/\(redTeamDeaths)/\(redTeamAssists)"
//        }
        
        
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return self.setupTeamCell(index: indexPath)
        } else {
            return self.setupPlayerCell(index: indexPath)
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
