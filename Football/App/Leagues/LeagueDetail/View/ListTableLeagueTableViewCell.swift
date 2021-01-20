//
//  ListTableLeagueTableViewCell.swift
//  Football
//
//  Created by admin on 1/14/21.
//

import UIKit

class ListTableLeagueTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var win: UILabel!
//
    @IBOutlet weak var played: UILabel!
    @IBOutlet weak var pts: UILabel!
    @IBOutlet weak var goalConDiff: UILabel!
    @IBOutlet weak var loses: UILabel!
    @IBOutlet weak var draw: UILabel!
    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var scoresStr: UILabel!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var iconTeam: UIImageView!
    @IBOutlet weak var stt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
