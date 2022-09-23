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
        
        let cs = participant.totalMinionsKilled
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
    
    func setItemImages(matchData: MatchData, index: Int) {
        var imagesDict = [Int: UIImage]()
        let player = matchData.info.participants[index]

        let itemIDArray = [player.item0, player.item1, player.item2, player.item3, player.item4, player.item5, player.item6]
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
        let championName = championJSONNames[championId.value]!
        
        if let image = UIImage(named: championName) {
            championImageView.image = image
        }
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
}
