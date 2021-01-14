//
//  ResultMatchViewController.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import UIKit

class ResultMatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    var matchesData : [String : Any]?
    var dataMatch : ResultMatch?
    
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
                
                print(data!["date"] as! String)
                if(data!["date"] as? String != nil ) {
                    self?.dataMatch?.date = data!["date"] as! String
                    print("hello : ",self?.dataMatch)
                }
//                if let date = data!["date"] as? String {
//                    self?.dataMatch?.date = date
//                    print("helloooo",self?.dataMatch)
//                }
//                self?.dataMatch? = data!
//                print("hello : ",self?.dataMatch)
//                self?.dataMatch?.date = data!["date"] as? String
//                self?.dataMatch?.leagues = data!["leagues"] as? [ResultMatchItem]
//                print("phamtuan",self?.dataMatch)
//                if let listArr = data!["leagues"] as? [[String : Any]] {
//                    self?.dataMatch?.leagues = listArr
//                    print("phamtuan",self?.dataMatch)
//                }
//                self?.dataMatch?.leagues = data!["leagues"] as? [[String : Any]]
//                print("phamtuan : ",self?.dataMatch?.leagues!)
//                self?.dataMatch = data
//                print("tuan : ",self!.dataMatch)
                
//                self?.dataMatch?.date = data!["date"] as? String
//                print("self?.dataMatch!.date",self?.dataMatch!.date)

//                    print("listArr",listArr)
//                    for obj in listArr {
//                        print("lplplp",obj)
//                        let matchesTuan = obj["matches"] as! [[String : Any]]
//                        print("matchesTuan",matchesTuan)
//                        let matchesObj = ResultMatchHomeTeamItem()
//
////                        matchesObj.idHometeam = matchesObj[]
////                        matchesObj.leagueId
//                    }
//                }
//                let leaguetuan = self!.dataMatch!["leagues"] as! [[String : Any]]
//                let leaguetuanFrist = leaguetuan[0]
//                print("leaguetuanFrist : ",leaguetuanFrist["matches"] as! [[String : Any]])
                self!.tableView.reloadData()
            }
        }
    }
}
    
extension ResultMatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListResultMatchTableViewCell", for: indexPath) as! ListResultMatchTableViewCell
        return cell
    }
    
}
