//
//  GameTableViewCell.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 7/17/21.
//

import UIKit
import LeagueAPI

class GameTableViewCell: UITableViewCell {

    @IBOutlet var championImageView: UIImageView!
    @IBOutlet var dSpellImageView: UIImageView!
    @IBOutlet var fSpellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBOutlet var rune1ImageView: UIImageView!
    @IBOutlet var rune2ImageView: UIImageView!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var kdaLabel: UILabel!
    @IBOutlet var matchTypeLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var indexLabel: UILabel!
    var backgroundColorIsSet: Bool = false
    var match: Match?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
