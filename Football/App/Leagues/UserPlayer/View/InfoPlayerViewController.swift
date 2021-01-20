//
//  InfoPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class InfoPlayerViewController: UIViewController {
//    var hellooId : Int?
    @IBOutlet weak var namePlayer: UILabel!
//    @IBOutlet weak var infoLeague: UIView!
    @IBOutlet weak var fotmobRatinView: UILabel!
    @IBOutlet weak var marketValuePlayer: UILabel!
    @IBOutlet weak var shirtPlayer: UILabel!
    @IBOutlet weak var countryPlayer: UILabel!
    @IBOutlet weak var agePLayer: UILabel!
    @IBOutlet weak var preferredFootPlayer: UILabel!
    @IBOutlet weak var heightPlayer: UILabel!
    @IBOutlet weak var infoDataView: UIView!
    var dataObj : InfoPlayerItemObj? = nil
//    let datafff = UserPlayerViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        infoDataView.layer.borderWidth = 1
        infoDataView.layer.borderColor = UIColor.systemGray6.cgColor
        infoDataView.layer.cornerRadius = 16
        fotmobRatinView.layer.cornerRadius = 4
        namePlayer.text = "hello"
        marketValuePlayer.text = "€ 125M"
        shirtPlayer.text = "11"
        countryPlayer.text = "EGY"
        agePLayer.text = "28"
        preferredFootPlayer.text = "Left"
        heightPlayer.text = "175 cm"
        
        
//        fetchDataUserPlayer(id: <#T##Int#>)
        // Do any additional setup after loading the view.
    }
    func getData(data : InfoPlayerItemObj) {
            print("dataxxxxxx",data)
//        let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
//        concurrentQueue.async {
//            self.dataObj = data
//            DispatchQueue.main.async { [self] in
//                namePlayer.text = self.dataObj?.name
//            }
//        }
    }
}
