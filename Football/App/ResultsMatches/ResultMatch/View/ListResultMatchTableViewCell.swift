//
//  ListResultMatchTableViewCell.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import UIKit

class ListResultMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var iconAwayTeam: UIImageView!
    @IBOutlet weak var iconHomeTeam: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
