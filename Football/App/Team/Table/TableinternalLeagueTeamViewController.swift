//
//  TableinternalLeagueTeamViewController.swift
//  Football
//
//  Created by admin on 2/22/21.
//

import UIKit

class TableinternalLeagueTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var dataTable : [TableTeamLeagueItem] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListTableLeagueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableLeagueTableViewCell")
        // Do any additional setup after loading the view.
        print("dataTable",dataTable[7].name)
    }

}

extension TableinternalLeagueTeamViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableLeagueTableViewCell", for: indexPath) as? ListTableLeagueTableViewCell
        let item = dataTable[indexPath.row]
        cell!.stt.text = String(item.idx!)
        cell!.nameTeam.text = item.name
        cell!.played.text = String(item.played!)
        cell!.win.text = String(item.wins!)
        cell!.draw.text = String(item.draws!)
        cell!.loses.text = String(item.losses!)
        cell!.scoresStr.text = String(item.scoresStr!)
        cell!.goalConDiff.text = String(item.goalConDiff!)
        cell!.pts.text = String(item.pts!)
        if let idClub = item.idTeam {
            cell!.iconTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(idClub))"), completed: nil)
        }
        
        return cell!
    }
    
}
