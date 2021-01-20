//
//  LeagueViewController.swift
//  Football
//
//  Created by admin on 1/12/21.
//

import UIKit
import SDWebImage

struct LeagueItem {
    var icon : String?
    var name : String
    var seo : String
    var idLeague : Int?
}
class LeagueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var dataLeague = [
        LeagueItem(icon: "https://www.fotmob.com/images/league/50", name: "EURO",seo : "euro",idLeague : 50),
        LeagueItem(icon: "https://www.fotmob.com/images/league/42", name: "CHAMPIONS LEAGUE",seo: "champions-league",idLeague : 42),
        LeagueItem(icon: "https://www.fotmob.com/images/league/73", name: "EUROPA LEAGUE",seo: "europa-league",idLeague : 73),
        LeagueItem(icon: "https://www.fotmob.com/images/league/47", name: "PREMIER LEAGUE",seo: "premier-league",idLeague : 47),
        LeagueItem(icon: "https://www.fotmob.com/images/league/54", name: "BUNDESLIGA",seo: "1.-bundesliga",idLeague : 54),
        LeagueItem(icon: "https://www.fotmob.com/images/league/87", name: "LALIGA",seo: "laliga",idLeague :87),
        LeagueItem(icon: "https://www.fotmob.com/images/league/53", name: "LIGUE 1",seo: "ligue-1",idLeague : 53),
        LeagueItem(icon: "https://www.fotmob.com/images/league/130", name: "MLS",seo: "mls",idLeague : 130),
        LeagueItem(icon: "https://www.fotmob.com/images/league/55", name: "SERIE A",seo: "serie-a",idLeague : 55),
        LeagueItem(icon: "https://www.fotmob.com/images/league/10175", name: "ALBANIA Supper-cup",seo: "super-cup",idLeague : 10175),
        LeagueItem(icon: "https://www.fotmob.com/images/league/260", name: "ALBANIA Superiore",seo: "superiore",idLeague : 260),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9173", name: "ALBANIA Superiore Qualification",seo: "superiore-qualification",idLeague : 9173),
        LeagueItem(icon: "https://www.fotmob.com/images/league/516", name: "ALGERIA Ligue-1",seo: "ligue-1",idLeague : 516),
        LeagueItem(icon: "https://www.fotmob.com/images/league/112", name: "ARGENTINA Superliga",seo: "liga-profesional",idLeague : 112),
        LeagueItem(icon: "https://www.fotmob.com/images/league/8965", name: "ARGENTINA PRIMERA B NACIONAL",seo: "primera-b-nacional",idLeague : 8965),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9213", name: "ARGENTINA PRIMERA B METROPOLITANA & TORNEO FEDERAL A",seo: "primera-b-metropolitana-%26-torneo-federal-a",idLeague : 9213),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9305", name: "COPA ARGENTINA",seo: "copa-argentina",idLeague : 9305),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9381", name: "ARGENTINA SUPER CUP",seo: "super-cup",idLeague : 9381),
        LeagueItem(icon: "https://www.fotmob.com/images/league/10007", name: "ARGENTINA COPA DIEGO MARADONA",seo: "copa-diego-maradona",idLeague : 10007),
        LeagueItem(icon: "https://www.fotmob.com/images/league/10075", name: "ARGENTINA TORNEO DE VERANO",seo: "torneo-de-verano",idLeague : 10075),
        LeagueItem(icon: "https://www.fotmob.com/images/league/10053", name: "TROFEO DE CAMPEONES",seo: "trofeo-de-campeones",idLeague : 10053),
        LeagueItem(icon: "https://www.fotmob.com/images/league/118", name: "ARMENIA",seo: "premier-league",idLeague : 118),
        LeagueItem(icon: "https://www.fotmob.com/images/league/113", name: "AUSTRALIA A-LEAGUE",seo: "a-league",idLeague : 113),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9471", name: "AUSTRALIA FFA CUP",seo: "ffa-cup",idLeague : 9471),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9495", name: "AUSTRALIA W-LEAGUE (W)",seo: "w-league-(w)",idLeague : 9495),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9088", name: "VIETNAM V-LEAGUE",seo: "v-league",idLeague : 9088),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9628", name: "VIETNAM V-LEAGUE QUALIFICATION",seo: "VIETNAM",idLeague : 9628),
        LeagueItem(icon: "https://www.fotmob.com/images/league/108", name: "ENGLAND LEAGUE 1",seo: "championship",idLeague : 108),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9628", name: "ENGLAND LEAGUE 1",seo: "league-1",idLeague : 9628),
        LeagueItem(icon: "https://www.fotmob.com/images/league/109", name: "ENGLAND LEAGUE 2",seo: "league-2",idLeague : 109),
        LeagueItem(icon: "https://www.fotmob.com/images/league/117", name: "ENGLAND NATIONAL LEAGUE",seo: "national-league",idLeague : 117),
        LeagueItem(icon: "https://www.fotmob.com/images/league/8944", name: "ENGLAND NATIONAL NORTH & SOUTH",seo: "national-north-%26-south",idLeague : 8944),
        LeagueItem(icon: "https://www.fotmob.com/images/league/8947", name: "ENGLAND PREMIER DIVISION",seo: "premier-division",idLeague : 8947),
        LeagueItem(icon: "https://www.fotmob.com/images/league/9084", name: "ENGLAND PREMIER LEAGUE 2 DIVISION 1",seo: "premier-league-2-div-1",idLeague : 9084),
        LeagueItem(icon: "https://www.fotmob.com/images/league/132", name: "ENGLAND FA CUP",seo: "fa-cup",idLeague : 132),
        LeagueItem(icon: "https://www.fotmob.com/images/league/86", name: "ITALY SERIE B",seo : "serie-b",idLeague : 86),
        LeagueItem(icon: "https://www.fotmob.com/images/league/141", name: "ITALY COPPA ITALIA",seo : "coppa-italia",idLeague : 141),
        LeagueItem(icon: "https://www.fotmob.com/images/league/147", name: "ITALY SERIE C",seo : "serie-c",idLeague : 147),
        LeagueItem(icon: "https://www.fotmob.com/images/league/222", name: "ITALY SUPER CUP",seo : "supercoppa",idLeague : 222),
        LeagueItem(icon: "https://www.fotmob.com/images/league/10178", name: "ITALY SERIE A WOMEN",seo : "serie-a-women",idLeague : 10178),
        LeagueItem(icon: "https://www.fotmob.com/images/league/140", name: "SPAIN LALIGA 2",seo : "laliga2",idLeague : 140),
        
        
        LeagueItem(icon: "https://www.fotmob.com/images/league/8968", name: "SPAIN SEGUNDA B",seo : "segunda-b",idLeague : 8968),
        
        LeagueItem(icon: "https://www.fotmob.com/images/league/138", name: "SPAIN COPA DEL REY",seo : "copa-del-rey",idLeague : 138),
        LeagueItem(icon: "https://www.fotmob.com/images/league/139", name: "SPAIN SUPER CUP",seo : "supercup",idLeague : 139),

        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "LeagueTableViewCell")
        tableView.showsVerticalScrollIndicator = false
    }
    
}

extension LeagueViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataLeague.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueTableViewCell", for: indexPath) as! LeagueTableViewCell
        let item = dataLeague[indexPath.row]
        cell.name.text = item.name
        if let imageUrl = item.icon {
            cell.icon.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailViewController") as?
            LeagueDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.seo = dataLeague[indexPath.row].seo
        vc?.idLeague = dataLeague[indexPath.row].idLeague
        vc?.name = dataLeague[indexPath.row].name
        vc?.icon = dataLeague[indexPath.row].icon
    }
    
    
}
