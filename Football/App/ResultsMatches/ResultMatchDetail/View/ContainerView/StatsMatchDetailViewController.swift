//
//  StatsMatchDetailViewController.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class StatsMatchDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // variable
    @IBOutlet weak var tableView: UITableView!
    var dataStats : [StatsOfStatsContentMatchesDetailItem] = []
    
    // cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListStatsMatchDetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListStatsMatchDetailTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    // call API
    func getApi(data : StatsContentMatchesDetailItem) {
        if data.stats != nil {
            self.dataStats = data.stats!
        }
        self.tableView.reloadData()
    }
}

// tableView
extension StatsMatchDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStats[section].stats!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListStatsMatchDetailTableViewCell", for: indexPath) as? ListStatsMatchDetailTableViewCell
        let section = self.dataStats[indexPath.section]
        let item = section.stats![indexPath.row]
        cell?.titleInfo.text = item.titleChild
        if let stasssss = item.stats as? [String] {
            for index in 0..<stasssss.count {
                 cell!.infoHome.text = stasssss[0]
                 cell!.infoAway.text = stasssss[1]
            }
        }
        switch item.highlighted {
        case "home":
            cell!.infoHome.backgroundColor = UIColor.orange
            cell!.infoHome.textColor = UIColor.white
            cell!.infoAway.backgroundColor = UIColor.white
            cell!.infoAway.textColor = UIColor.black
            break;
        case "away":
            cell!.infoAway.backgroundColor = UIColor.blue
            cell!.infoAway.textColor = UIColor.white
            cell!.infoHome.backgroundColor = UIColor.white
            cell!.infoHome.textColor = UIColor.black
            break;
        case "-":
            cell!.infoAway.backgroundColor = UIColor.white
            cell!.infoAway.textColor = UIColor.black
            cell!.infoHome.backgroundColor = UIColor.white
            cell!.infoHome.textColor = UIColor.black
            break;
        default:
            break;
        }
        return cell!
    }
    
}
