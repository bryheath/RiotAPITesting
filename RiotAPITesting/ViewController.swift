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
    var localMatches: [LOLMatchId] = []
    let formatter = NumberFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerNameTextField.text = "SunraiRW"
        getMatchList(for: preferredSummoner)
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
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
//        print("top of Prepare")
        
    }
    
    func getMatchList(for summonerName: String) {
        league.lolAPI.getSummoner(byName: summonerName, on: preferredRegion) { [self] (summoner, errorMsg) in
            if let summoner = summoner {
                self.summoner = summoner
                self.userNameLabel.setText(summoner.name)
                let iconID = "profileicon/" + String(summoner.iconId.value)
                self.userIconImageView.setImage(UIImage(named:iconID))
                self.userLevel.setText(String(summoner.level))
                self.getSummonerBestRank(summonerId: summoner.id) { bestRankedTier in
                    self.rankImageView.setImage(league.lolAPI.getEmblem(for: bestRankedTier))
                    guard let queue = Queue(.RankedSolo5V5) else { return }
                    league.lolAPI.getRankedEntry(for: summoner.id, in: queue, on: preferredRegion) { (rankedEntry, errorMsg) in
                        if let rankedEntry = rankedEntry {
                            if (rankedEntry.leagueInfo != nil) {
                                self.rankLabel.setText(("\(bestRankedTier.tier) \(rankedEntry.leagueInfo!.rank!) \(rankedEntry.leagueInfo!.leaguePoints!)LP"))
                            }
                        }
                    }
                }
                var matchDataList = [MatchParticipant]()
                league.lolAPI.getMatchList(by: summoner.puuid, on: preferredRegion, count: 20) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        self.localMatches = matchList
                        let myGroup = DispatchGroup()
                        let queue = DispatchQueue(label: "com.sunrai.queue")
                        queue.async {
                            for match in 0..<self.localMatches.count {
                                myGroup.enter()
                                self.getYouFromMatch(matchId: self.localMatches[match]) { game in
                                    matchDataList.append(game)
                                    myGroup.leave()
                                }
                                myGroup.wait()
                            }
                        }
                        myGroup.notify(queue: queue) {
                            DispatchQueue.main.async {
                                self.createChampionsUsedDictionary(matchDataList: matchDataList)
                            }
                        }
                    } else {
                        print("getMatchList Request failed cause: \(errorMsg ?? "No error description")")
                    }
                }
            } else {
                print("getMatchListSummoner Request failed cause: \(errorMsg ?? "No Error Description")")
            }
        }
    }
    
    func getYouFromMatch(matchId: LOLMatchId, completion: @escaping (MatchParticipant) -> Void) {
        league.lolAPI.getMatch(by: matchId, on: preferredRegion) { [self] (match, errorMsg) in
            if let match = match {
                let participants = match.info.participants
                for participant in 0..<participants.count {
                    if let summoner = summoner {
                        if summoner.name == participants[participant].summonerName {
                            completion(participants[participant])
                        }
                    }
                }
            } else {
                print("VC - getYourDataFromMatch Request failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    /*
     func loadDataFromMatch(matchId: LOLMatchId, completion: @escaping (Match) -> Void) {
         print("VC - loadDataFromMatch")
         league.lolAPI.getMatch(by: matchId, on: preferredRegion) { [self] (match, errorMsg) in
             print("VC - lDFM - getMatch")
             print("VC-lDFM-gM-\(matchId)")
             if let match = match {
                 let participants = match.info.participants
                 for participant in 0..<participants.count {
                     if let summoner = summoner {
                         if summoner.name == participants[participant].summonerName {
                             completion(MatchData(match: match, participant: participant))
                         }
                     }
                 }
             } else {
                 print("VC - getYourDataFromMatch Request failed cause: \(errorMsg ?? "No error description")")
             }
         }
     }
     */
        
    func getSummonerBestRank(summonerId: SummonerId, completion: @escaping (RankedTier) -> Void) {
            league.lolAPI.getRankedEntries(for: summonerId, on: preferredRegion) { (rankedPositions, errorMsg) in
                if let rankedPositions = rankedPositions {
                    let rankedTiers: [RankedTier] = rankedPositions.map( { position in
                        return position.tier!
                    })
                    let orderedTiers: [RankedTier.Tiers] = [.Challenger, .GrandMaster, .Master, .Diamond, .Platinum, .Gold, .Silver, .Bronze, .Iron]
                    for tier in orderedTiers {
                        if let bestTier = rankedTiers.filter( { rankedTier in return rankedTier.tier == tier }).first {
                            completion(bestTier)
                            return
                        }
                    }
                    completion(RankedTier(.Unranked)!)
                }
                else {
                    print("Request failed cause: \(errorMsg ?? "No error description")")
                }
            }
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
//                self.getSummonerBestRank(summonerId: summoner.id) { bestRankedTier in
//                    self.rankImageView.setImage(league.lolAPI.getEmblem(for: bestRankedTier))
//                    guard let queue = Queue(.RankedSolo5V5) else { return }
//                    league.lolAPI.getRankedEntry(for: summoner.id, in: queue, on: preferredRegion) { (rankedEntry, errormsg) in
//                        if let rankedEntry = rankedEntry {
//                            if (rankedEntry.leagueInfo != nil) {
//                                self.rankLabel.setText("\(bestRankedTier.tier) \(rankedEntry.leagueInfo!.rank) \(rankedEntry.leagueInfo!.leaguePoints)LP")
//                            }
//                        }
//                    }
//
//                }
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
    func createChampionsUsedDictionary(matchDataList: [MatchParticipant]) {
        for match in matchDataList {
            let champId = match.championId.value
            if championsUsedDictionary[champId] == nil {
                let usedChamp = UsedChampions(championID: match.championId)
                championsUsedDictionary[champId] = usedChamp
            }
            if championsUsedDictionary[champId] != nil {
                championsUsedDictionary[champId]!.howManyGames += 1
                championsUsedDictionary[champId]!.kills += Double(match.kills)
                championsUsedDictionary[champId]!.assists += Double(match.assists)
                championsUsedDictionary[champId]!.deaths += Double(match.deaths)
                championsUsedDictionary[champId]!.championID = match.championId
                if match.win {
                    championsUsedDictionary[champId]!.wins += 1
                }
            }
        }
        let sortedChampionsUsed = championsUsedDictionary.sorted { (first, second) -> Bool in
            return first.value.howManyGames > second.value.howManyGames
        }
        
        let champZero = sortedChampionsUsed[0].value
        let champOne = sortedChampionsUsed[1].value
        let champTwo = sortedChampionsUsed[2].value
        
        leftKDALabel.setText("\(getKDAStrings(champion: champZero)):1")
        middleKDALabel.setText("\(getKDAStrings(champion: champOne)):1")
        rightKDALabel.setText("\(getKDAStrings(champion: champTwo)):1")
        getChampionImage(championId: champZero.championID) { image in
            self.leftChampionImageView.setImage(image)
        }
        getChampionImage(championId: champOne.championID) { image in
            self.middleChampionImageView.setImage(image)
        }
        getChampionImage(championId: champTwo.championID) { image in
            self.rightChampionImageView.setImage(image)
        }
        leftWinRateLabel.setText("\(getWinRateString(champion: champZero))%")
        middleWinRateLabel.setText("\(getWinRateString(champion: champOne))%")
        rightWinRateLabel.setText("\(getWinRateString(champion: champTwo))%")
    }
    func getKDAStrings(champion: UsedChampions) -> String {
        let kda = (champion.kills + champion.assists) / champion.deaths
        let kdaString = formatter.string(for: kda) ?? ""
        return kdaString
    }
    
    func getWinRateString(champion: UsedChampions) -> String {
        let winRate = (champion.wins / champion.howManyGames) * 100.0
        let winRateString = formatter.string(for: winRate) ?? ""
        return winRateString
    }
//
//    func getSummonerBestRank(summonerId: SummonerId, completion: @escaping (RankedTier) -> Void) {
//        league.lolAPI.getRankedEntries(for: summonerId, on: preferredRegion) { (rankedPositions, errorMsg) in
//            if let rankedPositions = rankedPositions {
//                let rankedTiers: [RankedTier] = rankedPositions.map ( { position in
//                    if let tier = position.tier {
//                        return tier
//                    }
//                    return RankedTier(.Unknown)!
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

}

