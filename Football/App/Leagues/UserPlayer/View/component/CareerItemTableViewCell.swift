//
//  CareerItemTableViewCell.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class CareerItemTableViewCell: UITableViewCell {

    @IBOutlet weak var teamIcon: UIImageView!
    @IBOutlet weak var numberGoal: UILabel!
    @IBOutlet weak var numberMatch: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var team: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
