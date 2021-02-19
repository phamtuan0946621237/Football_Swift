//
//  FixtureTeamViewController.swift
//  Football
//
//  Created by admin on 2/18/21.
//

import UIKit

class FixtureTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var fixtureData : [FixTuresDataModel] = []
    @IBOutlet weak var tableView: UITableView!
    var idTeam : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FixtureTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "FixtureTableViewCell")
        print("fixtureData",fixtureData[0].home?.name)
        print("idTeam",idTeam)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtureData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultMatchDetailViewController") as?
            ResultMatchDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
//        vc?.fixtureData = self.fixtureData
        vc?.idMatch = fixtureData[indexPath.row].idMatch
//        idMatch
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FixtureTableViewCell", for: indexPath) as! FixtureTableViewCell
        let item = fixtureData[indexPath.row]
        if item.away?.idAway != idTeam {
            if let idTeam =  item.away?.idAway{
                cell.iconPartner.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((idTeam)))"), completed: nil)
            }
            cell.namePartner.text = item.away?.name
        }else {
            if let idTeam =  item.home?.idHome{
                cell.iconPartner.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((idTeam)))"), completed: nil)
            }
            cell.namePartner.text = item.home?.name
        }
        
        if item.status?.started == true {
            cell.result.text = item.status?.scoreStr
        }else {
            cell.result.text = item.status?.startTimeStr
        }
        
        cell.time.text = item.status?.startDateStr
        
        return cell
    }
}

