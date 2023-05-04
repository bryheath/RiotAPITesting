//
//  TeamTableViewCell.swift
//  RiotAPITesting
//
//  Created by Bryan Work on 8/2/21.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    
    @IBOutlet weak var dragonsKilled: UILabel!
    
    @IBOutlet weak var heraldsKilled: UILabel!
    
    @IBOutlet weak var towersDestroyed: UILabel!
    
    @IBOutlet weak var baronsKilled: UILabel!
    
    @IBOutlet weak var inhibsDestroyed: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
