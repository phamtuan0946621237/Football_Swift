//
//  ReusableFooter.swift
//  Football
//
//  Created by admin on 1/25/21.
//

import UIKit

class ReusableFooter: UIView {
//    @IBOutlet weak var titleText : UILabel!
    let nibName = "ReusableFooter"
    @IBOutlet weak var footerText: UILabel!
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
