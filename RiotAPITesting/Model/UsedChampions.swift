//
//  UsedChampions.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/7/21.
//

import Foundation
import LeagueAPI

class UsedChampions {
    var kills: Int = 0
    var deaths: Int = 0
    var assists: Int = 0
    var howManyGames: Int = 0
    var wins: Int = 0
    var championID: ChampionId
    var championName: String
    
    init(championID: ChampionId) {
        self.championID = championID
        if championNamesDictionary[championID.value] != nil {
            self.championName = championNamesDictionary[self.championID.value]!
        } else {
            self.championName = "Unknown"
        }
        
    }
    func addGame(match: Match) {
        
    }
}
