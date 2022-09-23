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
    
    //var matchDataList:[MatchData] = []
    //var matchDataList: [Int: Match] = [:]
    

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
                print(summoner.puuid)
                league.lolAPI.getMatchList(by: summoner.puuid, on: preferredRegion, count: 30) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        
                        self.matches = matchList
                        self.tableView.reload()
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
//        print(type(of: sender))
//        print(sender)
//        if segue.identifier == "toGameDetails" {
//            if let gameDetailsViewController = segue.destination as? GameDetailsViewController {
//                //gameDetailsViewController.match =
//                if let index = self.tableView.indexPathForSelectedRow?.row {
////                    print("Selected Index: \(index) - GameID: \(matchDataList[index].match.gameId)")
//
//                    print("Selected Index: \(index) - GameID: \(self.matchDataList[index]!.info.gameId)")
//                    gameDetailsViewController.matchData = matchDataList[index]
//                } else {
//                    print("Error")
//                }
//
//            }
//        }
    }
    
    func setupGameDetailsVC(_ gameDetailsVC: GameDetailsViewController, sender: Any?) {
        guard let matchDetails = sender as? Match else { return }
        gameDetailsVC.matchData = matchDetails
    }
    
    func setupMatchCell(matchId: LOLMatchId) -> GameTableViewCell {
        let gameCell: GameTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        guard let summoner = self.summoner else { return gameCell }
        
        
        self.getMatchDetails(matchId: matchId) { match in
            
            if let player = match.info.participants.first(where: { $0.summonerId == summoner.id}) {
                DispatchQueue.main.async {
                   gameCell.backgroundColor = player.win ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                }
                let kda = (player.kills + player.assists) / player.deaths
                gameCell.scoreLabel.setText("\(player.kills)/\(player.deaths)/\(player.assists)")
                gameCell.kdaLabel.setText("\(kda):1 KDA")
                let queue = QueueMode(Long(match.info.queueId))
                gameCell.matchTypeLabel.setText(queue.mode.description)
                let duration:TimeInterval = Double(match.info.gameDuration)
                gameCell.durationLabel.setText(duration.minuteSecond)
                gameCell.backgroundColorIsSet = true
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
//            if let summonerParticipant = match.info.participants.filter({ participant in
//                return participant.summonerId == summoner.id
//            }).first?.participantId {
//                if let summonerWon = match.info.filter({ team in
//                    return team.teamId == summonerParticipant.
//                }).first? {
//
//                }
//
//            }
//
//            let kda = (you.kills + you.assists) / you.deaths
//                gameCell.scoreLabel.setText("\(you.kills)/\(you.deaths)/\(you.assists)")
//                gameCell.kdaLabel.setText("\(kda):1 KDA")
//            let queue = QueueMode(Long(game.info.queueId))
//            gameCell.matchTypeLabel.setText(queue.mode.description)
//            gameCell.indexLabel.setText(String(index.row))
//            let duration:TimeInterval = Double(game.info.gameDuration)
//
//            gameCell.durationLabel.setText(duration.minuteSecond)
//            DispatchQueue.main.async {
//                gameCell.backgroundColorIsSet = true
//                gameCell.backgroundColor = you.win ? UIColor.green : UIColor.red
//            }
//            getSummonerSpells(participant: you) { (dSpellImage, fSpellImage) in
//                gameCell.dSpellImageView.setImage(dSpellImage)
//                gameCell.fSpellImageView.setImage(fSpellImage)
//            }
//            getRunePathImage(runePathId: you.perks.styles[0].style) { image in
//                gameCell.rune1ImageView.setImage(image)
//            }
//            getRunePathImage(runePathId: you.perks.styles[1].style) { image in
//                gameCell.rune2ImageView.setImage(image)
//            }
//                getChampionImage(championId: match.championId) { image in
//                    game.championImage = image
//                    gameCell.championImageView.setImage(image)
//                }
//                self.matchDataList.append(game)
//                self.matchDataList = self.matchDataList.sorted(by: {$0.match.gameId.value > $1.match.gameId.value})
//                self.matchDataList[index.row] = game
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

