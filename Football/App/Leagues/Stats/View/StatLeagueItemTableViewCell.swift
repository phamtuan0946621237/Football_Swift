//
//  StatLeagueItemTableViewCell.swift
//  Football
//
//  Created by admin on 1/18/21.
//

import UIKit

class StatLeagueItemTableViewCell: UITableViewCell {

    @IBOutlet weak var stt: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
