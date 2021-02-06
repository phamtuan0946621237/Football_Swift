//
//  ListHeadToHeadTableViewCell.swift
//  Football
//
//  Created by admin on 1/30/21.
//

import UIKit

class ListHeadToHeadTableViewCell: UITableViewCell {
    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var awayIcon: UIImageView!
    
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var result: UILabel!
//    @IBOutlet weak var awayIcon: UILabel!
    @IBOutlet weak var homeIcon: UIImageView!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
