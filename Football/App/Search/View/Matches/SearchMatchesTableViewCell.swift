//
//  SearchMatchesTableViewCell.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class SearchMatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var awayIcon: UIImageView!
    @IBOutlet weak var homeIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
