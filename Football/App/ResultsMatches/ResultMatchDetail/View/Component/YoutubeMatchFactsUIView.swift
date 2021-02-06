//
//  YoutubeMatchFactsUIView.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit

class YoutubeMatchFactsUIView: UIView {
    
    @IBOutlet weak var youtubeView: UIView!
    @IBOutlet weak var urlLink: UILabel!
    @IBOutlet weak var icon: UIImageView!
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
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
