//
//  ViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/9/21.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {
    let league = LeagueAPI(APIToken: "RGAPI-70c99cc7-efbf-402d-adfe-35d54578ed6c") //issued 7-17-21 255pm
    let accountID:AccountId = AccountId("U3JswvnYvMkTywOokmYUpAi0i0dLlW-LKY8m6yaKj0dWtPw")
    var players:[Player] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getSummoner(summoner: "SunraiRW", region: .NA)
        
    }
    
    func printPlayers() {
        for player in 0..<players.count {
            players[player].printDesc()
        }
    }
    func getSummoner(summoner: String, region: Region) {
        league.lolAPI.getSummoner(byName: summoner, on: region) { (name, errorMsg) in
            if let name = name {
                self.getMatches(summoner: name.name, region: region)
            }
        }
       
    }
    
    func getMatches(summoner: String, region: Region) {
        league.lolAPI.getSummoner(byName: summoner, on: region) { (name, errorMsg) in
            if let name = name {
                self.getMatchList(accountID: name.accountId, region: region)
            }
        }
    }
    func getMatchList(accountID: AccountId, region: Region) {
        self.league.lolAPI.getMatchList(by: accountID, on: region) { (matchList, errorMsg) in
            if let matchList = matchList {
                self.getMatch(gameID: matchList.matches[0].gameId, region: region)
            }
            
        }
    }
    
    func getMatch(gameID: GameId, region: Region) {
        self.league.lolAPI.getMatch(by: gameID, on: region) { (match, errorMsg) in
            if let match = match {
                print("==============================")
                print("Match Season: \(match.season.name)")
                print("Match Queue Mode: \(match.queueMode.mode)")
                print("Match Patch: \(match.patch)")
                print("Match Platform ID: \(match.platformId)")
                print("Match Game Mode: \(match.gameMode.mode)")
                print("Match Map: \(match.map.name)")
                print("Match Game Type: \(match.gameType.type)")
                let minutes = Int(floor(match.gameDuration.durationMinutes))
                let seconds = Int(round(60 * match.gameDuration.durationMinutes.truncatingRemainder(dividingBy: 1)))
                print("Match Game Duration: \(minutes):\(seconds)")
                print("Match Game Creation: \(match.gameCreation.date)")
                for participant in 0..<match.participants.count {
                    let part = match.participantsInfo[participant]
                    self.getChampionDetails(part: part, match: match, participant: participant)
                    
                }
            }
        }
    }
    
    func getChampionDetails(part: MatchParticipant, match: Match, participant: Int) {
        self.league.lolAPI.getChampionDetails(by: part.championId) { (champion, errorMsg) in
            if let champion = champion { self.league.lolAPI.getSummonerSpell(by: part.summonerSpell1) { (spell1, errorMsg) in
                    if let spell1 = spell1 {
                        self.league.lolAPI.getSummonerSpell(by: part.summonerSpell2) { (spell2, errorMsg) in
                            if let spell2 = spell2 {
                                let summonerName = match.participants[participant].player.summonerName
                                let teamID = (part.teamId == 100 ? "Red" : "Blue")
                                let kills = part.stats.kills
                                let deaths = part.stats.deaths
                                let assists = part.stats.assists
                                let dSpell = spell1.name
                                let fSpell = spell2.name
                                var KDA = Double(kills+assists) / Double(deaths)
                                KDA = round(KDA*100) / 100.0
                                let lane = part.timeline.lane
                                let role = part.timeline.role
                                let level = part.stats.champLevel
                                let position = self.getPosition(role: role, lane: lane)
                                let player = Player(number: participant, name: summonerName, champion: champion.name, dSpell: dSpell, fSpell: fSpell, team: teamID, level: level, kills: kills, deaths: deaths, assists: assists, kda: KDA, lane: lane, role: role, position: position)
                                self.players.append(player)
                                if self.players.count == 10 {
                                    self.sortPlayers()
                                    self.printPlayers()
                                }
                            } else { print("Error getSummonerSpell2: \(errorMsg ?? "No Error Description")")}
                        }
                    } else {print("Error getSummonerSpell1: \(errorMsg ?? "No Error Description")")}
                }
            } else {print("Error getMatch: \(errorMsg ?? "No Error Description")")}
        }
        printPlayers()
    }
        
    func getPosition(role: String, lane: String) -> String{
        var position: String
        switch role {
        case "DUO_CARRY": position = "Bottom"
        case "DUO_SUPPORT": position = "Support"
        case "NONE": position = "Jungle"
        case "SOLO":
            if lane == "TOP_LANE" {
                position = "Top"
            } else {
                position = "Mid"
            }
        default: position = "Unknown"
            
        }
        return position
    }
    
    func sortPlayers() {
        players = players.sorted()
    }

}

