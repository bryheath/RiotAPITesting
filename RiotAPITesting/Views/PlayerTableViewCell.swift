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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.frame.size.height = 60
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setSummonerSpellsForCell(participant: MatchParticipant) {
        let dSpell = summonerSpellFileNames[participant.summonerSpell1.value]
        let fSpell = summonerSpellFileNames[participant.summonerSpell2.value]
        dSpellImageView.image = UIImage(named: dSpell!)
        fSpellImageView.image = UIImage(named: fSpell!)
    }
    
    func setKDAForCell(stats: MatchParticipantStats) {
        let kills = stats.kills
        let deaths = stats.deaths
        let assists = stats.assists
        let kda = Double(kills+assists)/Double(deaths)
        let newKDA = formatter.string(for:kda)
        kdaLabel.text = "\(kills) / \(deaths) / \(assists) -- \(newKDA!): 1"
    }
    
    func setCSAndGoldLabel(matchData: MatchData) {
        let cs = matchData.stats.totalMinionsKilled
        let gameDuration = Double(matchData.match.gameDuration.minutes) + (Double(matchData.match.gameDuration.seconds) / 60.0)
        let csPerMinute = Double(cs) / gameDuration
        let newCSPerMinute = formatter.string(for: csPerMinute)
        let gold:Double = Double(matchData.stats.goldEarned) / 1000.0
        
        let newGold = formatter.string(for:gold)
        csGoldLabel.text = "\(cs)(\(newCSPerMinute!)) / \(newGold!)k"
        damageLabel.text = String(matchData.stats.totalDamageDealtToChampions)
    }
    
    func setRunePathImages(stats: MatchParticipantStats) {
        getRunePathImage(runePathId: stats.primaryRunePath!) { image in
            self.primaryRuneImageView.setImage(image) }
        getRunePathImage(runePathId: stats.secondaryRunePath!) { image in
            self.secondaryRuneImageView.setImage(image) }
    }
}
