//
//  PlayerTableViewCell.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/2/21.
//

import UIKit
import LeagueAPI

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var championImageView: UIImageView!
    @IBOutlet var dSpellImageView: UIImageView!
    @IBOutlet var fSpellImageView: UIImageView!
    @IBOutlet var primaryRuneImageView: UIImageView!
    @IBOutlet var secondaryRuneImageView: UIImageView!
    
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var kdaLabel: UILabel!
    
    @IBOutlet var item0ImageView: UIImageView!
    @IBOutlet var item1ImageView: UIImageView!
    @IBOutlet var item2ImageView: UIImageView!
    @IBOutlet var item3ImageView: UIImageView!
    @IBOutlet var item4ImageView: UIImageView!
    @IBOutlet var item5ImageView: UIImageView!
    @IBOutlet var item6ImageView: UIImageView! // Trinket
    
    @IBOutlet var csGoldLabel: UILabel!
    @IBOutlet var damageLabel: UILabel!
    
    let formatter = NumberFormatter()
    var match: Match?

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.frame.size.height = 60
        labelColors(color: .white)

        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 3
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setSummonerSpellsForCell(participant: MatchParticipant) {
        let dSpell = summonerSpellFileNames[participant.summoner1Id.value]
        let fSpell = summonerSpellFileNames[participant.summoner2Id.value]
            dSpellImageView.image = UIImage(named: dSpell!)
            fSpellImageView.image = UIImage(named: fSpell!)
    }
    
    func setKDAForCell(participant: MatchParticipant) {
            let kills = participant.kills
            let deaths = participant.deaths
            let assists = participant.assists
            let kda = Double(kills+assists)/Double(deaths)
            let newKDA = formatter.string(for:kda)
            kdaLabel.text = "\(kills) / \(deaths) / \(assists) -- \(newKDA!): 1"
    }

    func setCSAndGoldLabel(participant: MatchParticipant, gameDuration: Duration) {
        
        let cs = participant.totalMinionsKilled + participant.neutralMinionsKilled
            let decimalGameDuration = Double(gameDuration.minutes) + (Double(gameDuration.seconds) / 60.0)
            let csPerMinute = Double(cs) / decimalGameDuration
            let newCSPerMinute = formatter.string(for: csPerMinute)
            let gold:Double = Double(participant.goldEarned) / 1000.0
            
            let newGold = formatter.string(for:gold)
            csGoldLabel.text = "\(cs)(\(newCSPerMinute!)) / \(newGold!)k"
            damageLabel.text = String(participant.totalDamageDealtToChampions)
        
    }
    
//    func setRunePathImages(stats: MatchParticipantStats) {
//        getRunePathImage(runePathId: stats.primaryRunePath!) { image in
//            self.primaryRuneImageView.setImage(image) }
//        getRunePathImage(runePathId: stats.secondaryRunePath!) { image in
//            self.secondaryRuneImageView.setImage(image) }
//    }
    func setRunePathImages(participant: MatchParticipant) {
        getRunePathImage(runePathId: participant.perks.styles[0].style) { image in
            self.primaryRuneImageView.setImage(image) }
        getRunePathImage(runePathId: participant.perks.styles[1].style) { image in
            self.secondaryRuneImageView.setImage(image) }
    }
    
    func setPlayerNameLabel(summonerName: String) {
        self.playerNameLabel.text = summonerName
        
    }
    
    func setItemImages(participant: MatchParticipant) {
        var imagesDict = [Int: UIImage]()
        

        let itemIDArray = [participant.item0, participant.item1, participant.item2, participant.item3, participant.item4, participant.item5, participant.item6]
        let itemImageViewArray = [item0ImageView, item1ImageView, item2ImageView, item3ImageView, item4ImageView, item5ImageView, item6ImageView]
        
        for item in 0..<itemIDArray.count {
            
            getItemImage(itemId: itemIDArray[item]) { image in
                imagesDict[item] = image
                if let itemImage = itemImageViewArray[item] {
                    itemImage.setImage(imagesDict[item])
                }
            }
        }
    }
    
    func setChampionImage(participant: MatchParticipant) {
        let championId = participant.championId
        if let championName = getChampIdString(championId: championId) {
            if let image = UIImage(named: championName) {
                championImageView.image = image
            }
        } else {
            
            
            
        }
        //let championName = championJSONNames[championId.value]!
  
    }
    
    
    
    func labelColors(color: UIColor) {
        self.playerNameLabel.textColor = color
        self.kdaLabel.textColor = color
        self.csGoldLabel.textColor = color
        self.damageLabel.textColor = color
    }
    
//    func setup() {
//        if let matchData = matchData {
//            matchParticipant = matchData.match.participantsInfo[participantIndex]
//            setKDAForCell()
//            setRunePathImages()
//            setCSAndGoldLabel()
//            setSummonerSpellsForCell()
//            setPlayerNameLabel()
//            setItemImages()
//            setChampionImage()
//        }
//    }
    func getChampionImage(championId: ChampionId) {
        var url = URL(string:"")
        league.lolAPI.getChampionDetails(by: championId) { (champion, errorMsg) in
            if let champion = champion {
                league.lolAPI.getPatchVersion() { (version, errorMsg) in
                    if let version = version {
                        url = URL(string:"https://ddragon.leagueoflegends.com/cdn/\(version)/img/champion/\(champion.name).png")
                        
                        let session = URLSession(configuration: .default)
                        let downloadPicTask = session.dataTask(with: url!) { (data, response, error) in
                            if let e = error {
                                print("Error downloading champion icon: \(e)")
                            } else {
                                if response is HTTPURLResponse {
                                    if let imageData = data {
                                        let image = UIImage(data: imageData)
                                        self.championImageView.setImage(image)
                                    } else {
                                        print("Couldn't get image: Image is nil")
                                    }
                                } else {
                                    print("Couldn't get response code for some reason")
                                }
                            }
                        }
                        downloadPicTask.resume()
                    }
                }
            }
        }
    }
}
