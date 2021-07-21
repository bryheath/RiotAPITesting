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
    var currentGame: MatchData?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var matchDataList:[MatchData] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80
        getMatchList(for: preferredSummoner)
        
    }

    // MARK: - Table view data source

    func setupMatchCell(match: MatchReference) -> GameTableViewCell {
        let gameCell: GameTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
//        matchDataList.indexes(of: <#T##MatchData#>)
//        if matchDataList.contains(where: { specificMatch in specificMatch.gameID == match.gameId }) {
        if let found = matchDataList.first(where:{$0.gameID == match.gameId}) {
            gameCell.scoreLabel.setText("\(found.kills)/\(found.deaths)/\(found.assists)")
            
            gameCell.kdaLabel.setText("\(found.KDA):1 KDA")
            gameCell.matchTypeLabel.setText(found.queueMode)
            gameCell.durationLabel.setText("\(found.gameDurationMinutes) m \(found.gameDurationSeconds) s")
            if found.victory != nil {
                gameCell.backgroundColor = found.victory
            } else {
                if gameCell.backgroundColorIsSet == false {
                    if let summonerWon = found.match.teamsInfo.filter({ team in
                        return team.teamId == found.player.teamId
                        
                    }).first?.win {
                        DispatchQueue.main.async {
                            
                            gameCell.backgroundColorIsSet = true
                            found.victory = summonerWon ? UIColor.green : UIColor.red
                            gameCell.backgroundColor = found.victory
                        }
                    }
                }
            }
            
            gameCell.rune1ImageView.image = found.primaryRuneImage
            gameCell.rune2ImageView.image = found.secondaryRuneImage
            gameCell.dSpellImageView.image = found.dSpellImage
            gameCell.fSpellImageView.image = found.fSpellImage
            gameCell.championImageView.image = found.championImage
            
            print("Already in array")
//            matchDataList.enumerated().filter({ $0.})
            
        } else {
            self.getYourDataFromMatch(gameID: match.gameId) { game in
                self.currentGame = game
                gameCell.scoreLabel.setText("\(game.kills)/\(game.deaths)/\(game.assists)")
                
                gameCell.kdaLabel.setText("\(game.KDA):1 KDA")
                gameCell.matchTypeLabel.setText(game.queueMode)
                gameCell.durationLabel.setText("\(game.gameDurationMinutes) m \(game.gameDurationSeconds) s")
                if gameCell.backgroundColorIsSet == false {
                    if let summonerWon = game.match.teamsInfo.filter({ team in
                        return team.teamId == game.player.teamId
                        
                    }).first?.win {
                        DispatchQueue.main.async {
                            
                            gameCell.backgroundColorIsSet = true
                            game.victory = summonerWon ? UIColor.green : UIColor.red
                            gameCell.backgroundColor = game.victory
                        }
                    }
                }
                
                self.getSummonerSpells(participant: game.player) { (dSpellImage, fSpellImage) in
                    game.dSpellImage = dSpellImage
                    game.fSpellImage = fSpellImage
                    gameCell.dSpellImageView.setImage(dSpellImage)
                    gameCell.fSpellImageView.setImage(fSpellImage)
                }
                self.getRunePathImage(runePathId: game.player.stats.primaryRunePath!) { image in
                    game.primaryRuneImage = image
                    gameCell.rune1ImageView.setImage(image)
                }
                self.getRunePathImage(runePathId: game.player.stats.secondaryRunePath!) { image in
                    game.secondaryRuneImage = image
                    gameCell.rune2ImageView.setImage(image)
                }
                self.getChampionImage(championId: match.championId) { image in
                    game.championImage = image
                    gameCell.championImageView.setImage(image)
                    
                }
                self.matchDataList.append(game)
                print("New Match Appeneded in array")
            }
            
        }
        
        

        return gameCell
    }
    
    func getRuneImage(runeId: RuneId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getRune(by: runeId) { (rune, errorMsg) in
            if let rune = rune {
                rune.image.getImage() { (image, error) in
                    completion(image)
                }
            }
        }
        
    }
    
    func getRunePathImage(runePathId: RunePathId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getRunePath(by: runePathId) { (runePath, errorMsg) in
            if let runePath = runePath {
                runePath.image.getImage() { (image, error) in
                    completion(image)
                }
            }
        }
        
    }

    func getMatchList(for summonerName: String) {
        league.lolAPI.getSummoner(byName: summonerName, on: preferredRegion) { (summoner, errorMsg) in
            if let summoner = summoner {
                self.summoner = summoner
                league.lolAPI.getMatchList(by: summoner.accountId, on: preferredRegion, endIndex: 20) { (matchList, errorMsg) in
                    if let matchList = matchList {
                        matches = matchList.matches
                        print("AD match: \(matches.count)")
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
    
    func getChampionImage(championId: ChampionId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion, let defaultSkin = champion.images?.square {
                defaultSkin.getImage() { (image, error) in
                    completion(image)
                }
            } else {
                print("getChampionImageFailed: \(errorMsg ?? "No Error Description")")
            }
        }
    }
    
    func getSummonerSpellImage(summonerSpellId: SummonerSpellId, completion: @escaping (UIImage?) -> Void) {
        league.lolAPI.getSummonerSpell(by: summonerSpellId) { (summonerSpell, errorMsg) in
            if let summonerSpell = summonerSpell {
                summonerSpell.image.getImage() { (image, _) in
                    completion(image)
                }
            } else {
                print("getSummonerSpellImage Request Failed cause: \(errorMsg ?? "No error description")")
            }
        }
    }
    
    func getSummonerSpells(participant: MatchParticipant, completion: @escaping (UIImage?, UIImage?) -> Void) {
        var dSpell: UIImage?
        var fSpell: UIImage?
        var received: Int = 0
        self.getSummonerSpellImage(summonerSpellId: participant.summonerSpell1) { image in
            dSpell = image
            received += 1
            if received == 2 {
                completion(dSpell, fSpell)
            }
        }
        self.getSummonerSpellImage(summonerSpellId: participant.summonerSpell2) { image in
            fSpell = image
            received += 1
            if received == 2 {
                completion(dSpell, fSpell)
            }
        }
    }

    func getYourDataFromMatch(gameID: GameId, completion: @escaping (MatchData) -> Void) {
        league.lolAPI.getMatch(by: gameID, on: preferredRegion) { [self] (game, errorMsg) in
            if let game = game {
                for participant in 0..<game.participants.count {
                    if self.summoner?.name == game.participants[participant].player.summonerName {
                        let matchData = MatchData(match: game, participant: participant)
//
//                        let player = match.participantsInfo[participant]
//                        let championID = match.participantsInfo[participant].championId.value
//                        let champion = self.appDelegate.championNamesDictionary[championID]!
//
//                        let stats = player.stats
//                        let timeline = player.timeline
//                        let kills = stats.kills
//                        let deaths = stats.deaths
//                        let assists = stats.assists
//
//                        let lane = timeline.lane
//                        let role = timeline.role
//                        let level = stats.champLevel
//                        let matchData = MatchData(player: player, championID: championID, championName: champion, stats: stats, timeline: timeline, kills: kills, deaths: deaths, assists: assists, lane: lane, role: role, level: level)
//                        self.matchDataList.append(matchData)
                        completion(matchData)
                    }
                }
            } else {
                print("getYourDataFromMatch Request failed cause: \(errorMsg ?? "No error description")")
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

    
    

    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matches.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchAtIndex: MatchReference = matches[indexPath.row]
        print(matchAtIndex.gameId)
        return self.setupMatchCell(match: matchAtIndex)
        
        
        
    }
    
    
}

