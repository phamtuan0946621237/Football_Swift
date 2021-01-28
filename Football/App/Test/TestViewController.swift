//
//  TestViewController.swift
//  Football
//
//  Created by admin on 1/25/21.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    //    @IBOutlet weak var footerView: ReusableFooter!
    @IBOutlet weak var reusableFooterView : ReusableFooter!
    override func viewDidLoad() {
        super.viewDidLoad()
//        reusableFooterView.footerText.text = "hellooooooo "
//        reusableFooterView.helloTile = "hello world"
//        print("helloTile",reusableFooterView.helloTile )
//        let reusableFooterView = ReusableFooter()
//        reusableFooterView.footerText.text = "hello fwoefllk mw;l we "
//        firstView.addSubview(reusableFooterView)
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
            
        }else {
            firstView.alpha = 0
            secondView.alpha = 1
            
        }
    }
    
}
