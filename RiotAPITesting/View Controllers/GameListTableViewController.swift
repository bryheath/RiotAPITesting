//
//  GameListTableViewController.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/17/21.
//

import UIKit
import LeagueAPI
class GameListTableViewController: UITableViewController {
    var yourPlayer: Summoner?
    var players:[Player] = []
    private var summoner: Summoner?
    private var matches: [LOLMatchId] = []
    private var matchDetails: [LOLMatchId : Match] = [:]
    var currentGame: MatchData?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80
        getMatchList(for: preferredSummoner)
    }

    // MARK: - Table view data source

    func getMatchList(for summonerName: String) {
        league.lolAPI.getSummoner(byName: summonerName, on: preferredRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                self.summoner = summoner
                league.lolAPI.getMatchList(by: summoner.puuid, on: preferredRegion, count: 30) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        self.matches = matchList
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
    func getMatchDetails(matchId: LOLMatchId, completion: @escaping (Match) -> Void) {
        if let localGameDetails = self.matchDetails[matchId] {
            completion(localGameDetails)
        } else {
            league.lolAPI.getMatch(by: matchId, on: preferredRegion) { [self] (match, errorMsg) in
                if let match = match {
                    self.matchDetails[matchId] = match
                    completion(match)
                } else {
                    print("GLTVC - getYourDataFromMatch Request failed cause: \(errorMsg ?? "No error description")")
                }
            }
        }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? GameDetailsViewController {
                    print(type(of: sender))
                    //print(sender)
            self.setupGameDetailsVC(destinationVC, sender: sender)
        }
    }
    
    func setupGameDetailsVC(_ gameDetailsVC: GameDetailsViewController, sender: Any?) {
        guard let matchDetails = sender as? Match else { return }
        guard let summoner = self.summoner else { return }
        if let player = matchDetails.info.participants.first(where: { $0.summonerId == summoner.id}) {
            gameDetailsVC.winLoss = player.win
        }
        
        gameDetailsVC.matchData = matchDetails
    }
    func setupMatchCell(matchId: LOLMatchId) -> GameTableViewCell {
        let gameCell: GameTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        guard let summoner = self.summoner else { return gameCell }
        self.getMatchDetails(matchId: matchId) { match in
            if let player = match.info.participants.first(where: { $0.summonerId == summoner.id}) {
                DispatchQueue.main.async {
                   gameCell.backgroundColor = player.win ? winColor : lossColor
                }
                let kda:Double = (Double(player.kills) + Double(player.assists)) / Double(player.deaths)
                let cs = player.totalMinionsKilled + player.neutralMinionsKilled
                let duration:TimeInterval = Double(match.info.gameDuration)
                gameCell.scoreLabel.setText("\(player.kills)/\(player.deaths)/\(player.assists) -- \(cs) CS")
                let decimalGameDuration = Double(duration.minute) + (Double(duration.second) / 60.0)
                let csPerMinute = Double(cs) / decimalGameDuration
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.maximumSignificantDigits = 3
                let csPerMinString:String = formatter.string(for: csPerMinute)!
                var kdaString:String = formatter.string(for: kda)!
                if kdaString == "NaN" { kdaString = "0" }
                gameCell.kdaLabel.setText("\(kdaString):1 KDA -- \(csPerMinString) CS/m")
                let queue = QueueMode(Long(match.info.queueId))
                let queueFormatted = formatQueue(mode: queue.mode.description)
                gameCell.matchTypeLabel.setText(queueFormatted)
                gameCell.durationLabel.setText(duration.minuteSecond)
                gameCell.backgroundColorIsSet = true
                getChampionImage(championId: player.championId) { (champImage) in
                    gameCell.championImageView.setImage(champImage)
                }
                
                getSummonerSpells(participant: player) { (dSpellImage, fSpellImage) in
                    gameCell.dSpellImageView.setImage(dSpellImage)
                    gameCell.fSpellImageView.setImage(fSpellImage)
                }
                getRunePathImage(runePathId: player.perks.styles[0].style) { image in
                gameCell.rune1ImageView.setImage(image)
                }
                getRunePathImage(runePathId: player.perks.styles[1].style) { image in
                gameCell.rune2ImageView.setImage(image)
                }
                gameCell.match = match
            }
        }
        return gameCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.setupMatchCell(matchId: self.matches[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let matchId = self.matches[indexPath.row]
        guard let match: Match = self.matchDetails[matchId] else { return }
        self.performSegue(withIdentifier: "toGameDetails", sender: match)
    }

}

