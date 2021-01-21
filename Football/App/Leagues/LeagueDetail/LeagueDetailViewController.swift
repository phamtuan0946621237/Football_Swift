//
//  LeagueDetailViewController.swift
//  Football
//
//  Created by admin on 1/12/21.
//

import UIKit

class LeagueDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    // variable
    var selectedIndex : Int? = 0
    var tableTeamLeague : LeagueDetailItem?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var iconLeague: UIImageView!
    @IBOutlet weak var nameLeague: UILabel!
    var seo : String?
    var idLeague : Int?
    var name : String?
    var icon : String?
    var dataFeature = ["TABLE","MATCHES","STARS","NEWS","TRANSFERS"]
    let loadingView = ModalViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        getView() // view
        dataAPI(id: self.idLeague!, seo: self.seo!) //api
        loadingView.showLoading()
    }

}
// view
extension LeagueDetailViewController {
    func getView() {
        self.title = self.name
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ListTableLeagueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableLeagueTableViewCell")
        nameLeague.text  = self.name
        if let imageUrl = self.icon {
            iconLeague.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
    }
}

// collection View
extension LeagueDetailViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFeature.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureLeagueCollectionViewCell", for: indexPath) as! FeatureLeagueCollectionViewCell
        cell.titleFeature.text = dataFeature[indexPath.row]
        if indexPath.row == self.selectedIndex {
            cell.titleFeature.textColor = UIColor.red
        }else {
            cell.titleFeature.textColor = UIColor.black
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        collectionView.reloadData()
        if(selectedIndex == 0) {
//            print(selectedIndex)
//            tableView.register(UINib(nibName: "ListTableLeagueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableLeagueTableViewCell")
            
        }
        if(selectedIndex == 2 ) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "StatsLeagueViewController") as? StatsLeagueViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.idLeague = self.idLeague
            vc?.seo = self.seo
        }
        if(selectedIndex == 3 ) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.idLeague = self.idLeague
            vc?.seo = self.seo
        }
        if(selectedIndex == 4 ) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TransfersViewController") as? TransfersViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.idLeague = self.idLeague
            vc?.seo = self.seo
        }
     }
    
}
// tableView
extension LeagueDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tableTeamLeague!.tableData!.tables![0].tables == nil {
            return tableTeamLeague!.tableData!.tables![section].table!.count
        }
        return (tableTeamLeague!.tableData!.tables![0].tables![section].table!.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableTeamLeague?.tableData == nil {
            return 0
        }
        if tableTeamLeague?.tableData!.tables! == nil {
            return 0
        }
        if self.tableTeamLeague!.tableData!.tables![0].tables == nil {
            return (tableTeamLeague?.tableData!.tables!.count)!
        }else {
            return tableTeamLeague!.tableData!.tables![0].tables!.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemGray6
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
        titleLabel.textColor = .black
        titleLabel.text = tableTeamLeague!.tableData!.tables![0].tables != nil ? tableTeamLeague?.tableData?.tables![0].tables![section].leagueName : tableTeamLeague?.tableData?.tables![0].leagueName
            view.addSubview(titleLabel)
            return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableLeagueTableViewCell", for: indexPath) as! ListTableLeagueTableViewCell
        if (self.tableTeamLeague!.tableData!.tables![0].tables == nil) {
            var sectionData = tableTeamLeague?.tableData?.tables![indexPath.section]
            let item = sectionData?.table![indexPath.row]
            if item != nil {
                cell.stt.text = String(item!.idx!)
                cell.nameTeam.text = item!.name
                cell.played.text = String(item!.played!)
                cell.win.text = String(item!.wins!)
                cell.draw.text = String(item!.draws!)
                cell.loses.text = String(item!.losses!)
                cell.scoresStr.text = String(item!.scoresStr!)
                cell.goalConDiff.text = String(item!.goalConDiff!)
                cell.pts.text = String(item!.pts!)
                cell.iconTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item!.idTeam!))"), completed: nil)
            }
        }else {
            var sectionData = tableTeamLeague?.tableData?.tables![0].tables![indexPath.section]
            let item = sectionData?.table![indexPath.row]
            if item != nil {
                cell.stt.text = String(item!.idx!)
                cell.nameTeam.text = item!.name
                cell.played.text = String(item!.played!)
                cell.win.text = String(item!.wins!)
                cell.draw.text = String(item!.draws!)
                cell.loses.text = String(item!.losses!)
                cell.scoresStr.text = String(item!.scoresStr!)
                cell.goalConDiff.text = String(item!.goalConDiff!)
                cell.pts.text = String(item!.pts!)
                cell.iconTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item!.idTeam!))"), completed: nil)
            }
        }
            return cell
    }
}
// get Data
extension LeagueDetailViewController {
    func dataAPI(id : Int,seo : String) {
        let parameters : [String : Any]? = ["id" : id,"tab" : "overview","type" : "league","timeZone" : "Asia%2FSaigon","seo" : seo]
        let service = Connect()
        service.fetchGet(endPoint: "leagues",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                let detailLeagueInfo = LeagueDetailItem()
                if let tableDataObj = data!["tableData"] as? [String : Any] {
                    if let tablesArr = tableDataObj["tables"] as? [[String : Any]] {
                        var tableArray : [ChartsTeamOfLeague] = []
                        for tablesObj in tablesArr {
                            let tablesItem = ChartsTeamOfLeague()
                            tablesItem.ccode = tablesObj["tables"] as? [[String : Any]] == nil ? tablesObj["ccode"] as? String : ""
                            tablesItem.leagueId = tablesObj["leagueId"] as? Int
                            tablesItem.pageUrl = tablesObj["pageUrl"] as? String
                            tablesItem.leagueName = tablesObj["leagueName"] as? String
                            if (tablesObj["tables"] as? [[String : Any]] == nil) {
                                var tableAr : [TableTeamLeagueItem] = []
                                if let tableqqq = tablesObj["table"] as? [[String : Any]] {
                                    for tableqqq in tableqqq {
                                        let tableqqqItem = TableTeamLeagueItem()
                                        tableqqqItem.qualColor = tableqqq["qualColor"] as? String
                                        tableqqqItem.idx = tableqqq["idx"] as? Int
                                        tableqqqItem.name = tableqqq["name"] as? String
                                        tableqqqItem.idTeam = tableqqq["id"] as? Int
                                        tableqqqItem.pageUrl = tableqqq["pageUrl"] as? String
                                        tableqqqItem.played = tableqqq["played"] as? Int
                                        tableqqqItem.wins = tableqqq["wins"] as? Int
                                        tableqqqItem.draws = tableqqq["draws"] as? Int
                                        tableqqqItem.losses = tableqqq["losses"] as? Int
                                        tableqqqItem.scoresStr = tableqqq["scoresStr"] as? String
                                        tableqqqItem.goalConDiff = tableqqq["goalConDiff"] as? Int
                                        tableqqqItem.pts = tableqqq["pts"] as? Int
                                        tableAr.append(tableqqqItem)
                                    }
                                    tablesItem.table = tableAr
                                }
                            }else {
                                var tablesArrs : [TablesTeamItem] = []
                                if let tablesppp = tablesObj["tables"] as? [[String : Any]] {
                                    for tableqqqObj in tablesppp {
                                        let tableqqqItem = TablesTeamItem()
                                        tableqqqItem.ccode = tableqqqObj["ccode"] as? String
                                        tableqqqItem.leagueId = tableqqqObj["leagueId"] as? Int
                                        tableqqqItem.pageUrl = tableqqqObj["pageUrl"] as? String
                                        tableqqqItem.leagueName = tableqqqObj["leagueName"] as? String
                                        tablesArrs.append(tableqqqItem)
                                        var tableAr : [TableTeamLeagueItem] = []
                                        if let tableqqq = tableqqqObj["table"] as? [[String : Any]] {
                                            for tableqqq in tableqqq {
                                                let tableqqqItem = TableTeamLeagueItem()
                                                tableqqqItem.qualColor = tableqqq["qualColor"] as? String
                                                tableqqqItem.idx = tableqqq["idx"] as? Int
                                                tableqqqItem.name = tableqqq["name"] as? String
                                                tableqqqItem.idTeam = tableqqq["id"] as? Int
                                                tableqqqItem.pageUrl = tableqqq["pageUrl"] as? String
                                                tableqqqItem.played = tableqqq["played"] as? Int
                                                tableqqqItem.wins = tableqqq["wins"] as? Int
                                                tableqqqItem.draws = tableqqq["draws"] as? Int
                                                tableqqqItem.losses = tableqqq["losses"] as? Int
                                                tableqqqItem.scoresStr = tableqqq["scoresStr"] as? String
                                                tableqqqItem.goalConDiff = tableqqq["goalConDiff"] as? Int
                                                tableqqqItem.pts = tableqqq["pts"] as? Int
                                                tableAr.append(tableqqqItem)
                                            }
                                            tableqqqItem.table = tableAr
                                        }
                                    }
                                    tablesItem.tables = tablesArrs
                                }
                            }
                            tableArray.append(tablesItem)
                        }
                        let tablePPP = TableDataItem()
                        tablePPP.tables = tableArray
                        detailLeagueInfo.tableData = tablePPP
                    }
                }
                
                self?.tableTeamLeague = detailLeagueInfo
                self!.loadingView.hideLoading()
                self!.tableView.reloadData()
        }
    }
}
}
