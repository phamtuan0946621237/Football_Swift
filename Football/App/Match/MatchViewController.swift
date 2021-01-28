//
//  MatchViewController.swift
//  Football
//
//  Created by admin on 1/18/21.
//

import UIKit

class MatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
//    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var tableView: UITableView!

//       var tableView = UITableView()
    var data = ["a","b","c"]
    @IBOutlet weak var matchesLayoutView: UIView!
    //    let dataSource = ["ViewController one","ViewController 2","ViewController 3","ViewController 4"]
//    var currentViewControllerIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhamtuanRightTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PhamtuanRightTableViewCell")
        matchesLayoutView.addSubview(tableView)
//        var view = PhamtuanLeft(frame: CGRect(x: 0, y: 0, width: matchesLayoutView.frame.size.width, height: matchesLayoutView.frame.size.height))
//        view.titleTest.text = "hello"
//        view.backgroundColor = .red
//        matchesLayoutView.addSubview(view)
//        tableView.alpha = 1
//        view.alpha = 0
        self.fetchDataUserPlayer(id: 292462)
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let firstView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            firstView.backgroundColor = .red
            let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)

        }else {
            let view = PhamtuanLeft(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
            view.titleTest.text = "hello"
            view.backgroundColor = .red
            
            let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
            
        }
    }
}
extension MatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhamtuanRightTableViewCell" , for: indexPath) as? PhamtuanRightTableViewCell
        cell!.titleAAA.text = data[indexPath.row]
        return cell!
    }
}

extension MatchViewController {
    func fetchDataUserPlayer(id : Int) {
        let parameters : [String : Any]? = ["id" : id]
        let service = Connect()
        
        service.fetchGet(endPoint: "playerData",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                print("phamtuan",data)
//                self!.titleName.text = "hellloooo world"
            }
        }
    }
}
