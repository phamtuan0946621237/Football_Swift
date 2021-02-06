//
//  LiveTickerInfoPlayerView.swift
//  Football
//
//  Created by admin on 2/2/21.
//

import UIKit

class LiveTickerInfoPlayerView: UIView {

    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var iconPlayer: UIImageView!
    let nibName = "LiveTickerInfoPlayerView"
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
