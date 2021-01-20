//
//  UserPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class UserPlayerViewController: UIViewController {
    var idPlayer : Int?
    var dataInfoPlayer : InfoPlayerItemObj?
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    var infoUser = InfoPlayerViewController()
    override func viewDidLoad() {
//        self.infoUser.hellooId = 123
        super.viewDidLoad()
//        print(idPlayer as Any)
        fetchDataUserPlayer(id: idPlayer!)
        
//        getData
        // Do any additional setup after loading the view.
    }
    
    @IBAction func switchView(_ sender: UISegmentedControl) {
        print("hhhhhhh",sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 1
            
        }else if  sender.selectedSegmentIndex == 1{
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
        }
    }
}
extension UserPlayerViewController {
    func fetchDataUserPlayer(id : Int) {
        let parameters : [String : Any]? = ["id" : id]
        let service = Connect()
        service.fetchGet(endPoint: "playerData",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                print("UserPlayerViewController : ",data)
                if let dataObj = data {
                    let dataItem = InfoPlayerItemObj()
                    dataItem.name = dataObj["name"] as? String
                    self!.dataInfoPlayer = dataItem
                    print("helloooooaaaaa : ",self!.dataInfoPlayer!.name)
                    self!.infoUser.getData(data : self!.dataInfoPlayer!)
                }
            }
        }
    }
}
