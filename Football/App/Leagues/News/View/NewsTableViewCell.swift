//
//  NewsTableViewCell.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var sourceIcon: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var layoutView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layoutView.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
