//
//  LeftUIViewController.swift
//  Football
//
//  Created by admin on 1/26/21.
//

import UIKit

class LeftUIViewController: UIViewController {

    @IBOutlet weak var uiViewHeader: ReusableFooter!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiViewHeader.footerText.text = "hellooo world"
        // Do any additional setup after loading the view.
    }
    


}
