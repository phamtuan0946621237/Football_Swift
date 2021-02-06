//
//  LineupTableViewCell.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit

class LineupTableViewCell: UITableViewCell {

    @IBOutlet weak var namePlayerAway: UILabel!
    @IBOutlet weak var namePlayerHome: UILabel!
    @IBOutlet weak var iconPlayerAway: UIImageView!
    @IBOutlet weak var iconPlayerHome: UIImageView!
    @IBOutlet weak var starAway: UILabel!
    @IBOutlet weak var starHome: UILabel!
    @IBOutlet weak var iconChangeAway: UIImageView!
    @IBOutlet weak var iconChangeHome: UIImageView!
    @IBOutlet weak var timeAwayChange: UILabel!
    @IBOutlet weak var timeHomeChange: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
