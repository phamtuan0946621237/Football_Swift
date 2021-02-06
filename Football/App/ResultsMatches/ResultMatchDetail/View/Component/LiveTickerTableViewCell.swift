//
//  LiveTickerTableViewCell.swift
//  Football
//
//  Created by admin on 2/1/21.
//

import UIKit

class LiveTickerTableViewCell: UITableViewCell {

    @IBOutlet weak var infoPlayerView: UIView!
    @IBOutlet weak var layoutViewAwy: UIView!
    
    
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var nameTeamAwy: UILabel!
    @IBOutlet weak var iconteamAwy: UIImageView!
    @IBOutlet weak var nameAwayPlayer: UILabel!
    @IBOutlet weak var iconAwayPlayer: UIImageView!
    @IBOutlet weak var iconChange: UIImageView!
    @IBOutlet weak var nameTeamHome: UILabel!
    @IBOutlet weak var iconTeamHome: UIImageView!
    @IBOutlet weak var namePlayerHome: UILabel!
    @IBOutlet weak var iconPlayerHome: UIImageView!
    @IBOutlet weak var describle: UILabel!
    @IBOutlet weak var titleLiveTicker: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoPlayerView.layer.cornerRadius = 12
        infoPlayerView.layer.borderWidth = 1
        infoPlayerView.layer.borderColor = UIColor.systemGray6.cgColor
        layoutViewAwy.layer.cornerRadius = 12
        layoutViewAwy.layer.borderWidth = 1
        layoutViewAwy.layer.borderColor = UIColor.systemGray6.cgColor
        
        infoPlayerView.convert(CGRect(x: 0, y: 0, width: 0, height: 20), to: infoPlayerView)
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
