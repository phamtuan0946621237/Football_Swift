//
//  FixtureTableViewCell.swift
//  Football
//
//  Created by admin on 2/18/21.
//

import UIKit

class FixtureTableViewCell: UITableViewCell {

    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var namePartner: UILabel!
    @IBOutlet weak var iconPartner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
