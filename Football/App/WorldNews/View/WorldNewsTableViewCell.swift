//
//  WorldNewsTableViewCell.swift
//  Football
//
//  Created by admin on 1/22/21.
//

import UIKit

class WorldNewsTableViewCell: UITableViewCell {

    @IBOutlet weak var layoutView: UIView!
    @IBOutlet weak var nameSource: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var imageUrl: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUrl.layer.cornerRadius = 16
        layoutView.layer.cornerRadius = 16
        layoutView.layer.cornerRadius = 16
        
        layoutView.layer.shadowColor = UIColor.systemGray4.cgColor
        layoutView.layer.shadowOpacity = 1
        layoutView.layer.shadowOffset = .zero
        layoutView.layer.shadowRadius = 10
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
