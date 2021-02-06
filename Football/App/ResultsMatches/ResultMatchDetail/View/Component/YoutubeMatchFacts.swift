//
//  YoutubeMatchFacts.swift
//  Football
//
//  Created by admin on 1/30/21.
//

import UIKit

class YoutubeMatchFacts: UIView {

    @IBOutlet weak var url: UILabel!
    @IBOutlet weak var image: UIImageView!
    let nibName = "YoutubeMatchFacts"
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
