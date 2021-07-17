//
//  File.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/13/21.
//

import Foundation
// Do any additional setup after loading the view.
//        guard let queueMode = QueueMode(.AllRandomSummonersRift) else { return }
//guard let season = Season(.Unknown) else { return }


//league.lolAPI.getSummoner(byName: "SunraiRW", on: .NA) { (summoner, errorMsg) in
//    if let summoner = summoner {
////                print("Success!")
////                print("AccountID: \(summoner.accountId)")
////                print("SummonerID: \(summoner.id)")
//        self.league.lolAPI.getMatchList(by: summoner.accountId, on: .NA) { (matchList, errorMsg) in
//            if let matchList = matchList {
//                
//                //for match in 0..<matchList.matches.count {
////                        for match in 0..<1{
////                            print("Game ID: \(matchList.matches[match].gameId)")
////                            print("Season: \(matchList.matches[match].season)")
////                            print("Queue: \(matchList.matches[match].queue.mode)")
////                            print("Champion ID: \(matchList.matches[match].championId)")
////                            print("Lane: \(matchList.matches[match].lane)")
////                            print("Role: \(matchList.matches[match].role)")
////                            print("Platform ID: \(matchList.matches[match].platformId)")
////                            print("Game Date: \(matchList.matches[match].gameDate.date)")
////                        }
//                self.league.lolAPI.getMatch(by: matchList.matches[0].gameId, on: .NA) { (match, errorMsg) in
//                    if let match = match {
//                        print("==============================")
//                        print("Match Season: \(match.season.name)")
//                        print("Match Queue Mode: \(match.queueMode.mode)")
//                        print("Match Patch: \(match.patch)")
//                        print("Match Platform ID: \(match.platformId)")
//                        print("Match Game Mode: \(match.gameMode.mode)")
//                        print("Match Map: \(match.map.name)")
//                        print("Match Game Type: \(match.gameType.type)")
//                        let minutes = Int(floor(match.gameDuration.durationMinutes))
//                        let seconds = Int(round(60 * match.gameDuration.durationMinutes.truncatingRemainder(dividingBy: 1)))
//                        print("Match Game Duration: \(minutes):\(seconds)")
//                        print("Match Game Creation: \(match.gameCreation.date)")
//                        for participants in 0..<match.participants.count {
//                            let part = match.participantsInfo[participants]
//                            let teamID = part.teamId
//                            let kills = part.stats.kills
//                            let deaths = part.stats.deaths
//                            let assists = part.stats.assists
//                            var KDA = Double(kills+assists) / Double(deaths)
//                            let lane = part.timeline.lane
//                            let role = part.timeline.role
//                            var position = ""
//                            switch role {
//                            case "DUO_CARRY":
//                                position = "Bottom"
//                            case "DUO_SUPPORT":
//                                position = "Support"
//                            case "NONE":
//                                position = "Jungle"
//                            case "SOLO":
//                                if lane == "TOP_LANE" {
//                                    position = "Top"
//                                } else {
//                                    position = "Mid"
//                                }
//                            default:
//                                position = "Unknown"
//                                
//                            }
//                            KDA = round(KDA*100) / 100.0
//                            self.league.lolAPI.getChampionDetails(by: part.championId) { (name, errorMsg) in
//                                if let name = name { self.league.lolAPI.getSummonerSpell(by: part.summonerSpell1) { (spell1, errorMsg) in
//                                        if let spell1 = spell1 {
//                                            self.league.lolAPI.getSummonerSpell(by: part.summonerSpell2) { (spell2, errorMsg) in
//                                                if let spell2 = spell2 {
//                                                    print("********************")
//                                                    print("Participant #\(participants): \(match.participants[participants].player.summonerName)")
//                                                    print("Champion: \(name.name)")
//                                                    print("D: \(spell1.name)")
//                                                    print("F: \(spell2.name)")
//                                                    print(teamID == 100 ? "Team: Red" : "Team: Blue")
//                                                    print("Level: \(part.stats.champLevel)")
//                                                    print("KDA: \(kills)/\(deaths)/\(assists) (\(KDA))")
//                                                    
//                                                    
//                                                    print("Lane: \(part.timeline.lane)")
//                                                    print("Role: \(part.timeline.role)")
//                                                    print("Position: \(position)")
//                                                    
//                                                } else { print("Error getSummonerSpell2: \(errorMsg ?? "No Error Description")")}
//                                            }
//                                        } else {print("Error getSummonerSpell1: \(errorMsg ?? "No Error Description")")}
//                                    }
//                                } else {print("Error getMatch: \(errorMsg ?? "No Error Description")")}
//                            }
//                        }
//                    } else { print("Error getMatch: \(errorMsg ?? "No Error Description")") }
//                }
//            } else { print("Error getMatchList: \(errorMsg ?? "No Error Description")") }
//        }
//    } else {print("Request failed cause: \(errorMsg ?? "No error description")")}
//}
//
//
////
////
//////        league.riotAPI.getAccount(byRiotId: RiotId(gameName: "SunraiRW", tagLine: "NA1"), on: .America) { (riotAccount, errorMsg) in
//////            if let riotAccount = riotAccount {
//////                league.lolAPI.getMatchList(by: riotAccount, on: .NA, beginTime: Datetime(), endTime: Datetime().datetimeByAdding(month: 1), beginIndex: 0, endIndex: 100, championId: nil, queue: queueMode, season: nil) { (match, errorMsg) in
//////                    print("Success")
//////
//////                }
//////            } else {
//////                print("Request failed cause: \(errorMsg ?? "No error description")")
//////            }
//////        }
//////
////
////        league.lolAPI.getAllChampionIds() { (championIds, errorMsg) in
////            if let championIds = championIds {
////                print("gACID Success!")
////                print(championIds)
////            } else {
////                print("Request Failed: \(errorMsg ?? "No Desc")")
////            }
////        }
////        league.lolAPI.getAllChampionNames() { (championNames, errorMsg) in
////            if let championNames = championNames {
////                print("gACN Success!")
////                print(championNames)
////            } else {
////                print("Request Failed: \(errorMsg ?? "No Desc")")
////            }
////        }
////        league.lolAPI.getChampionDetails(byName: "Diana") { (champion, errorMsg) in
////            if let champion = champion {
////                print("Success!")
////                print(champion.championId)
////            } else {
////                print("Request Failed: \(errorMsg ?? "No Desc")")
////            }
////        }
////
////        league.lolAPI.getChampionMasteries(by: SummonerId("bbG7MVAkzdJ1sGFA4_5gMG-i3uCIHXlA8kuOjtJXWG35qqM"), on: .NA) { (masteries, errorMsg) in
////            if let masteries = masteries {
////                print("masteries success!")
////                for i in 0..<masteries.count {
////                    self.league.lolAPI.getChampionDetails(by: masteries[i].championId) { (champName, errorMsg) in
////                        print("Name: \(champName!.name), Level: \(masteries[i].championLevel), Points: \(masteries[i].championPoints)")
////                    }
////
////                }
//////                print(masteries)
////            }
////        }
