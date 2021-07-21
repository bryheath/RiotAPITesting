//
//  MatchData.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/17/21.
//

import Foundation
import LeagueAPI
class MatchData: NSObject {
    
    var player:MatchParticipant
    
    
    var championID: Long
    var championName: String
    var match: Match

    var stats:MatchParticipantStats
    var timeline:MatchParticipantTimeline
    var kills:Int
    var deaths:Int
    var assists:Int
    var KDA:Double
    var lane:String
    var role:String
//    var position:String
    var level:Int
    var dSpell: String
    var fSpell: String
    var dSpellImage: UIImage?
    var fSpellImage: UIImage?
    var primaryRuneImage: UIImage?
    var secondaryRuneImage: UIImage?
    var championImage: UIImage?
    var queueMode: String
    var gameMode: String
    var gameType: String
    var gameDurationMinutes: Int
    var gameDurationSeconds: Int
    var gameCreation: Date
    var gameID: GameId
    var victory: UIColor?

    
//    init(player: MatchParticipant, championID: Long, championName: String, stats: MatchParticipantStats, timeline: MatchParticipantTimeline, kills: Int, deaths: Int, assists: Int, lane: String, role: String, level: Int, queueMode: String, gameMode: String, gameType:String, gameDurationMinutes: Int, gameDurationSeconds: Int, gameCreation: Date) {
    init(match: Match, participant: Int) {
        self.player = match.participantsInfo[participant]
        self.championID = player.championId.value
        self.championName = championNamesDictionary[championID]!
        self.match = match
        self.stats = player.stats
        self.timeline = player.timeline
        self.kills = stats.kills
        self.deaths = stats.deaths
        self.assists = stats.assists
        self.KDA = round((Double(kills+assists) / Double(deaths))*100) / 100.0
        self.lane = timeline.lane
        self.role = timeline.role
        self.level = stats.champLevel
        self.queueMode = match.queueMode.mode.description
        self.gameMode = match.gameMode.mode.description
        self.gameType = match.gameType.type.description
        self.gameDurationMinutes = Int(floor(match.gameDuration.durationMinutes))
        self.gameDurationSeconds = Int(round(60 * match.gameDuration.durationMinutes.truncatingRemainder(dividingBy: 1)))
        self.gameCreation = match.gameCreation.date
        self.gameID = match.gameId
        self.dSpell = summonerSpellDictionary[player.summonerSpell1.value]!
        self.fSpell = summonerSpellDictionary[player.summonerSpell2.value]!
        
//        self.position = self.getPosition(role: self.role, lane: self.lane)
    }
//    func getPosition(role: String, lane: String) -> String{
//        var position: String
//        switch role {
//        case "DUO_CARRY": position = "Bottom"
//        case "DUO_SUPPORT": position = "Support"
//        case "NONE": position = "Jungle"
//        case "SOLO":
//            if lane == "TOP_LANE" {
//                position = "Top"
//            } else {
//                position = "Mid"
//            }
//        default: position = "Unknown"
//
//        }
//        return position
//    }
}


//let player = match.participantsInfo[participant]
//let championID = match.participantsInfo[participant].championId.value
//let champion = self.appDelegate.championNamesDictionary[championID]!
//
//let stats = player.stats
//let timeline = player.timeline
//let kills = stats.kills
//let deaths = stats.deaths
//let assists = stats.assists
//
//let lane = timeline.lane
//let role = timeline.role
//let level = stats.champLevel
//let matchData = MatchData(player: player, championID: championID, championName: champion, stats: stats, timeline: timeline, kills: kills, deaths: deaths, assists: assists, lane: lane, role: role, level: level)
//self.matchDataList.append(matchData)
