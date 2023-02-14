//
//  UsedChampions.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/7/21.
//

import Foundation
import LeagueAPI

class UsedChampions {
    var kills: Double = 0
    var deaths: Double = 0
    var assists: Double = 0
    var howManyGames: Double = 0
    var wins: Double = 0
    var championID: ChampionId
    var championName: String
    
    init(championID: ChampionId) {
        self.championID = championID
        if let champ = championsDictionary[championID.value] {
            self.championName = champ.name
        } else {
            self.championName = "Unknown"
        }
        
    }
    func addGame(match: Match) {
        
    }
}
