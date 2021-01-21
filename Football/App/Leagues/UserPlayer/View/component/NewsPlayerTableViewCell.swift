//
//  NewsPlayerTableViewCell.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class NewsPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var sourceIcon: UIImageView!
    @IBOutlet weak var sourceStr: UILabel!
    @IBOutlet weak var imageUrlNews: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
