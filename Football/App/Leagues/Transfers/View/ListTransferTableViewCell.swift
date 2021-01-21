//
//  ListTransferTableViewCell.swift
//  Football
//
//  Created by admin on 1/21/21.
//

import UIKit

class ListTransferTableViewCell: UITableViewCell {

    @IBOutlet weak var layoutItem: UIView!
    @IBOutlet weak var iconToClub: UIImageView!
    @IBOutlet weak var iconFromClub: UIImageView!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var toClub: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fromClub: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var marketValue: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutItem.layer.cornerRadius = 24
        layoutItem.layer.shadowColor = UIColor.systemGray5.cgColor
        layoutItem.layer.shadowOpacity = 1
        layoutItem.layer.shadowOffset = .zero
        layoutItem.layer.shadowRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
