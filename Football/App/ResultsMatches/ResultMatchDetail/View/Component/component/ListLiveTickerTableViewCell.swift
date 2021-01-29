//
//  ListLiveTickerTableViewCell.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class ListLiveTickerTableViewCell: UITableViewCell {

    @IBOutlet weak var valueListLiveTicker: UILabel!
    @IBOutlet weak var titleListLiveTicker: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
