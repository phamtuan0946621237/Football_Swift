//
//  ListStatsFilterTableViewCell.swift
//  Football
//
//  Created by admin on 1/19/21.
//

import UIKit

class ListStatsFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var stt: UILabel!
    @IBOutlet weak var layoutItem: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutItem.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
