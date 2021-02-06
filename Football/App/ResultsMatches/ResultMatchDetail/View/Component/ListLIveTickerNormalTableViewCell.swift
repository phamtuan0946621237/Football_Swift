//
//  ListLIveTickerNormalTableViewCell.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit
typealias handleHeightText = (CGFloat) -> ()
class ListLIveTickerNormalTableViewCell: UITableViewCell {
    var getHeight : handleHeightText?
    @IBOutlet weak var describleView: UIView!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    
    func getTitle(textTitle : String) {
        let heightDescrible = self.heightForView(text: textTitle, font: UIFont.systemFont(ofSize: 17), width: describleView.frame.size.width - 32)
        
        let proNameLbl = UILabel(frame: CGRect(x: 16, y: 0, width: describleView.frame.size.width - 32, height: heightDescrible))
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
    
    func setHeight(handle : @escaping handleHeightText) {
        self.getHeight = handle
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
