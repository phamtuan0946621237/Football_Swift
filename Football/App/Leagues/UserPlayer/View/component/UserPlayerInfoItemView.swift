//
//  UserPlayerInfoItemView.swift
//  Football
//
//  Created by admin on 1/26/21.
//

import UIKit

class UserPlayerInfoItemView: UIView {
    let nibName = "UserPlayerInfoItemView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconPlayer: UIImageView!
    @IBOutlet weak var valueHeight: UILabel!
    @IBOutlet weak var valuePrefer: UILabel!
    @IBOutlet weak var valueCountry: UILabel!
    @IBOutlet weak var valueMarket: UILabel!
    @IBOutlet weak var valueShirt: UILabel!
    @IBOutlet weak var valueAge: UILabel!
    @IBOutlet weak var valuematches: UILabel!
    @IBOutlet weak var otherPosition: UILabel!
    @IBOutlet weak var mainPosition: UILabel!
    @IBOutlet weak var iconLeague: UIImageView!
    @IBOutlet weak var valueRating: UILabel!
    @IBOutlet weak var valueAssist: UILabel!
    @IBOutlet weak var valueGoals: UILabel!
    @IBOutlet weak var nameLeague: UILabel!
    
    @IBOutlet weak var iconClub: UIImageView!
    @IBOutlet weak var nameClub: UILabel!
    
    var helloTile : String?
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
    
        
    override init(frame: CGRect) {
            
        super.init(frame: frame)
            
            commonInit()
        }
        
        func commonInit() {
            guard let view = loadViewFromNib() else { return }
            view.frame = self.bounds
            
            self.addSubview(view)
        }
        
        func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: nibName, bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }
}
