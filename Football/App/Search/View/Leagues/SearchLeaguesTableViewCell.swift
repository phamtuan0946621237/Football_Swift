//
//  SearchLeaguesTableViewCell.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class SearchLeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLeague: UILabel!
    @IBOutlet weak var iconLeague: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
