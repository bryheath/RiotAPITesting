//
//  ViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/9/21.
//

import UIKit
import LeagueAPI

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var matchList: MatchList?
    var summoner: Summoner?
    var region: Region?
    var currentGame: MatchData?
    //var localMatches: [MatchReference] = []
    var localMatches: [GameId] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        playerNameTextField.text = "SunraiRW"
        print("ViewController - viewDidLoad")
        //getMatchList(for: preferredSummoner)
        //print("ViewController - viewDidLoad - after getMatchList")
    }
    
    @IBOutlet var userView: UIView!
    @IBOutlet var playerNameTextField: UITextField!
    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var userLevel: UILabel!
    
    @IBOutlet var championStackView: UIStackView!
    @IBOutlet var leftView: UIView!
    @IBOutlet var leftChampionImageView: UIImageView!
    @IBOutlet var leftWinRateLabel: UILabel!
    @IBOutlet var leftKDALabel: UILabel!
    
    @IBOutlet var middleView: UIView!
    @IBOutlet var middleChampionImageView: UIImageView!
    @IBOutlet var middleWinRateLabel: UILabel!
    @IBOutlet var middleKDALabel: UILabel!
    
    @IBOutlet var rightView: UIView!
    @IBOutlet var rightChampionImageView: UIImageView!
    @IBOutlet var rightWinRateLabel: UILabel!
    @IBOutlet var rightKDALabel: UILabel!
    var championsUsedDictionary = [Long : UsedChampions]()
    
    @IBAction func lookupButtonPressed(_ sender: UIButton) {
        if playerNameTextField.text != nil && playerNameTextField.text != "" {
            preferredSummoner = playerNameTextField.text!
            self.performSegue(withIdentifier: "lookupSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("top of Prepare")
        
    }
//    func getMatchList(for summonerName: String) {
//        print("ViewController - getMatchList")
//        league.lolAPI.getSummoner(byName: summonerName, on: preferredRegion) { [self] (summoner, errorMsg) in
//            print("ViewController - getMatchList - getSummoner")
//            if let summoner = summoner {
//                self.summoner = summoner
//                print(summoner.puuid)
//                self.userNameLabel.setText(summoner.name)
//                
//                let iconID = "profileicon/" + String(summoner.iconId.value)
//                self.userIconImageView.setImage(UIImage(named:iconID))
//                self.userLevel.setText(String(summoner.level))
////                self.getSummonerBestRank(summonerId: summoner.id) { bestRankedTier in
////                    self.rankImageView.setImage(league.lolAPI.getEmblem(for: bestRankedTier))
////                    guard let queue = Queue(.RankedSolo5V5) else { return }
//////                    league.lolAPI.getRankedEntry(for: summoner.id, in: queue, on: preferredRegion) { (rankedEntry, errormsg) in
//////                        if let rankedEntry = rankedEntry {
//////                            if (rankedEntry.leagueInfo != nil) {
//////                                self.rankLabel.setText("\(bestRankedTier.tier) \(rankedEntry.leagueInfo!.rank) \(rankedEntry.leagueInfo!.leaguePoints)LP")
//////                            }
//////                        }
//////                    }
////
////                }
//                var matchDataList = [MatchData]()
////                league.lolAPI.getMatchList(by: summoner.accountId, on: preferredRegion, endIndex: 18) { (matchList, errorMsg) in
//                league.lolAPI.getMatchList(by: summoner.puuid, on: preferredRegion) { [self] (matchList, errorMsg) in
//                        print("ViewController - getMatchList - getSummoner - getMatchList")
//                        if let matchList = matchList {
//                            print(matchList)
//                            self.localMatches = matchList.matches
//                            print("localMatches: \(localMatches)")
//                            let myGroup = DispatchGroup()
//                            let queue = DispatchQueue(label: "com.sunrai.queue")
//                            queue.async {
//                                print("VC - GML - GS - GML - queue.async")
//                                print("QA - localMatches.count: \(self.localMatches.count)")
//                                for match in 0..<self.localMatches.count {
//                                    myGroup.enter()
//                                    self.loadDataFromMatch(matchId: matchList.matches[match]) { game in
//                                        print("VC - GML - GS - GML - QA - loadDataFroMatch")
//                        
//                                            matchDataList.append(game)
//                                            myGroup.leave()
//                                        }
//                                    myGroup.wait()
//                                }
//                            }
//                            myGroup.notify(queue: queue) {
//                                DispatchQueue.main.async {
//                                    self.createChampionUsedDictionary(matchDataList: matchDataList)
//                                }
//                            }
//                        } else {
//                            print("getMatchList Request failed cause: \(errorMsg ?? "No error description")")
//                        }
//                    }
//            } else {
//                print("getMatchListSummoner Request failed cause: \(errorMsg ?? "No Error Description")")
//            }
//            
//        }
//    }
//    
//    func createChampionUsedDictionary(matchDataList: [MatchData]) {
//        for match in matchDataList {
//            let you = match.you
//            let champId = you.championId.value
//            if championsUsedDictionary[champId] == nil {
//                let usedChamp = UsedChampions(championID: you.championId)
//                championsUsedDictionary[champId] = usedChamp
//            }
//            if championsUsedDictionary[champId] != nil {
//                championsUsedDictionary[champId]!.howManyGames += 1
//                championsUsedDictionary[champId]!.kills += you.kills
//                championsUsedDictionary[champId]!.assists += you.assists
//                championsUsedDictionary[champId]!.deaths += you.deaths
//                championsUsedDictionary[champId]!.championID = you.championId
//                print(you.win)
//                if you.win { championsUsedDictionary[champId]!.wins += 1 }
//            }
//        }
//        let sortedChampionsUsed = championsUsedDictionary.sorted { (first, second) -> Bool in
//            return first.value.howManyGames > second.value.howManyGames
//        }
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumSignificantDigits = 3
//        var kda = (Double(sortedChampionsUsed[0].value.kills) + Double(sortedChampionsUsed[0].value.assists)) / Double(sortedChampionsUsed[0].value.deaths)
//        var kdaString = formatter.string(for: kda) ?? ""
//        leftKDALabel.setText("\(kdaString):1")
//        kda = (Double(sortedChampionsUsed[1].value.kills) + Double(sortedChampionsUsed[1].value.assists)) / Double(sortedChampionsUsed[1].value.deaths)
//        kdaString = formatter.string(for: kda) ?? ""
//        middleKDALabel.setText("\(kdaString):1")
//        kda = (Double(sortedChampionsUsed[2].value.kills) + Double(sortedChampionsUsed[2].value.assists)) / Double(sortedChampionsUsed[2].value.deaths)
//        kdaString = formatter.string(for: kda) ?? ""
//        rightKDALabel.setText("\(kdaString):1")
//        getChampionImage(championId: sortedChampionsUsed[0].value.championID) { image in
//            self.leftChampionImageView.setImage(image)
//        }
//        getChampionImage(championId: sortedChampionsUsed[1].value.championID) { image in
//            self.middleChampionImageView.setImage(image)
//        }
//        getChampionImage(championId: sortedChampionsUsed[2].value.championID) { image in
//            self.rightChampionImageView.setImage(image)
//        }
//        
//        var winRate = Double(sortedChampionsUsed[0].value.wins / sortedChampionsUsed[0].value.howManyGames) * 100.0
//        var winRateString = formatter.string(for: winRate) ?? ""
//        leftWinRateLabel.setText("\(winRateString)%")
//        winRate = Double(sortedChampionsUsed[1].value.wins / sortedChampionsUsed[1].value.howManyGames) * 100.0
//        winRateString = formatter.string(for: winRate) ?? ""
//        middleWinRateLabel.setText("\(winRateString)%")
//        winRate = Double(sortedChampionsUsed[2].value.wins / sortedChampionsUsed[2].value.howManyGames) * 100.0
//        winRateString = formatter.string(for: winRate) ?? ""
//        rightWinRateLabel.setText("\(winRateString)%")
//    }
//    
//    /*func getSummonerBestRank(summonerId: SummonerId, completion: @escaping (RankedTier) -> Void) {
//        league.lolAPI.getRankedEntries(for: summonerId, on: preferredRegion) { (rankedPositions, errorMsg) in
//            if let rankedPositions = rankedPositions {
//                let rankedTiers: [RankedTier] = rankedPositions.map( { position in
//                    return position.tier
//                })
//                let orderedTiers: [RankedTier.Tiers] = [.Challenger, .GrandMaster, .Master, .Diamond, .Platinum, .Gold, .Silver, .Bronze, .Iron]
//                for tier in orderedTiers {
//                    if let bestTier = rankedTiers.filter( { rankedTier in return rankedTier.tier == tier }).first {
//                        completion(bestTier)
//                        return
//                    }
//                }
//                completion(RankedTier(.Unranked)!)
//            }
//            else {
//                print("Request failed cause: \(errorMsg ?? "No error description")")
//            }
//        }
//    }
//     
//    
//    func getSummonerRanked(participant: Participant, completion: @escaping (RankedTier) -> Void) {
//        if let summonerId = participant.summonerId {
//            self.getSummonerBestRank(summonerId: summonerId) { bestRank in
//                completion(bestRank)
//            }
//        }
//        else {
//            league.lolAPI.getSummoner(byName: participant.summonerName, on: preferredRegion) { (summoner, errorMsg) in
//                if let summoner = summoner {
//                    self.getSummonerBestRank(summonerId: summoner.id) { bestRank in
//                        completion(bestRank)
//                    }
//                }
//                else {
//                    print("Request failed cause: \(errorMsg ?? "No error description")")
//                }
//            }
//        }
//    }
//    */
//    func loadDataFromMatch(matchId: MatchId, completion: @escaping (MatchData) -> Void) {
//        print("VC - loadDataFromMatch")
//        league.lolAPI.getMatch(by: matchId, on: preferredRegion) { [self] (match, errorMsg) in
//            print("VC - lDFM - getMatch")
//            print("VC-lDFM-gM-\(matchId)")
//            if let match = match {
//                let participants = match.info.participants
//                for participant in 0..<participants.count {
//                    if let summoner = summoner {
//                        if summoner.name == participants[participant].summonerName {
//                            completion(MatchData(match: match, participant: participant))
//                        }
//                    }
//                }
//            } else {
//                print("VC - getYourDataFromMatch Request failed cause: \(errorMsg ?? "No error description")")
//            }
//        }
//    }
}

