//
//  ResultMatchViewController.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import UIKit

class ResultMatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    var dataMatch : [String : Any]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListResultMatchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListResultMatchTableViewCell")
        dataAPI()
    }
}

extension ResultMatchViewController {
    func dataAPI() {
        let parameters : [String : Any]? = ["date" : "20210111","sortOnClient" : true]
        let service = Connect()
        service.fetchGet(endPoint: "matches",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                self!.dataMatch = data
                
//                print("tuan : ",self!.dataMatch)
                let leaguetuan = self!.dataMatch!["leagues"] as! [[String : Any]]
                let leaguetuanFrist = leaguetuan[0]
//                print("leaguetuanFrist : ",leaguetuanFrist["matches"] as! [[String : Any]])
                self!.tableView.reloadData()
            }
        }
    }
}
    
extension ResultMatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("aaaaaaaaa",dataMatch!["leagues"] as! [[String : Any]])
//        let listLeague : [[String : Any]] = dataMatch["leagues"] as! [[String; (Any).self;]]
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListResultMatchTableViewCell", for: indexPath) as! ListResultMatchTableViewCell
        return cell
    }
    
}
