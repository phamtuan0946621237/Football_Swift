//
//  HeadToHeadResultMatchViewController.swift
//  Football
//
//  Created by admin on 1/30/21.
//

import UIKit

class HeadToHeadResultMatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var awayWin: UILabel!
    @IBOutlet weak var draw: UILabel!
    @IBOutlet weak var homeWin: UILabel!
    var tableData : [MatchHeadToHeadContentMatchesDetailItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListHeadToHeadTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListHeadToHeadTableViewCell")
        // Do any additional setup after loading the view.
    }
    func getTableData(data : [MatchHeadToHeadContentMatchesDetailItem]) {
        tableData = data
        tableView.reloadData()
        
    }
//

}
extension HeadToHeadResultMatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListHeadToHeadTableViewCell", for: indexPath) as? ListHeadToHeadTableViewCell
        let item = tableData[indexPath.row]
        cell?.time.text = item.time
        cell?.homeName.text = item.home?.name
        cell?.awayName.text = item.away?.name
        cell?.league.text = item.league?.name
        cell?.result.text = item.status?.scoreStr
        if let idTeam = item.home?.idTeam {
            cell!.homeIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((idTeam)))"), completed: nil)
        }
        if let idTeam = item.away?.idTeam {
            cell!.awayIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((idTeam)))"), completed: nil)
        }
        
        return cell!
    }
}
