//
//  ListLiveTickerCardTableViewCell.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit
typealias handleHeightTextLiveTickerCard = (CGFloat) -> ()

class ListLiveTickerCardTableViewCell: UITableViewCell {
    @IBOutlet weak var describleView: UIView!
    @IBOutlet weak var nameTeamAway: UILabel!
    @IBOutlet weak var iconTeamAway: UIImageView!
    @IBOutlet weak var nameAway: UILabel!
    @IBOutlet weak var iconAway: UIImageView!
    @IBOutlet weak var nameTeamHOme: UILabel!
    @IBOutlet weak var iconTeamHome: UIImageView!
    @IBOutlet weak var nameHome: UILabel!
    @IBOutlet weak var iconHome: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    var getHeight : handleHeightTextLiveTickerCard?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getTitle(textTitle : String) {
        let heightDescrible = self.heightForView(text: textTitle, font: UIFont.systemFont(ofSize: 17), width: describleView.frame.size.width )
        
        let proNameLbl = UILabel(frame: CGRect(x: 0, y: 0, width: describleView.frame.size.width , height: heightDescrible))
        if let getHeight = self.getHeight {
            getHeight(heightDescrible)
        }
        proNameLbl.text = textTitle
        proNameLbl.backgroundColor = .white
        proNameLbl.font = UIFont.systemFont(ofSize: 17)
        proNameLbl.numberOfLines = 0
        proNameLbl.lineBreakMode = .byWordWrapping
        describleView.addSubview(proNameLbl)
    }
    
    func setHeight(handle : @escaping handleHeightTextLiveTickerCard) {
        self.getHeight = handle
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
