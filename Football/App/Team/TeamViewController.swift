//
//  TeamViewController.swift
//  Football
//
//  Created by admin on 2/17/21.
//

import UIKit

class TeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var nameLeague: UILabel!
    @IBOutlet weak var imageTeam: UIImageView!
    var dataTable : [TableTeamLeagueItem] = []
    var fixtureData : [FixTuresDataModel] = []
    var newsData : [NewsItem] = []
    var url : String! = nil
    var arrHeader : [String] = []
    var detailDataTeam : DetailTeamModelItemData?
    @IBOutlet weak var tableView: UITableView!
    var idTeam : Int = 0
    var nameClub : String?
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.global().async { [weak self] in
            self!.getInfoTeam()
            DispatchQueue.main.async {
                self!.dataAPI(id: String(self!.idTeam), nameTeam: self!.nameClub!)
            }
        }
    }
    
    // get info team
    func getInfoTeam() {
        let dateAsString = url
        let start = dateAsString!.index(dateAsString!.startIndex, offsetBy: 7)
        let end = dateAsString!.index(dateAsString!.endIndex, offsetBy: 0)
        let range = start..<end
        let month = dateAsString![range]
        let a = month.prefix(5)
        let b = month.prefix(6)
        let indexChuChuoiCungcuaA = a.index(before: a.endIndex)
        let indexChuChuoiCungcuaB = b.index(before: b.endIndex)
        if a[indexChuChuoiCungcuaA] == "/" {
            let id = month.prefix(4)
            self.idTeam = Int(id)!
        }else {
            let id = month.prefix(5)
            self.idTeam = Int(id)!
        }
        if let index = month.lastIndex(of: "/") {
            let z = month.suffix(from: index)
            let aaaaaa = z.index(z.endIndex, offsetBy: -z.count + 1)
            let nameClub = z.suffix(from: aaaaaa)
            self.nameClub = String(nameClub)
            
        }
    }
}



// call API
extension TeamViewController {
    func dataAPI(id : String,nameTeam : String) {
        let parameters : [String : Any]? = ["id" : id,"tab" : "overview","type" : "team","timeZone" : "Asia%2FSaigon","seo" : nameTeam]
        let service = Connect()
        service.fetchGet(endPoint: "teams",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                DispatchQueue.global().async { [weak self] in
                    if let detailTeamObj  = data!["details"] as? [String : Any] {
                        let detailTeamData = DetailTeamModelItemData()
                        detailTeamData.idTeam = detailTeamObj["id"] as? Int
                        detailTeamData.country = detailTeamObj["country"] as? String
                        detailTeamData.type = detailTeamObj["type"] as? String
                        detailTeamData.name = detailTeamObj["name"] as? String
                        self!.detailDataTeam = detailTeamData
                        
                    }
                    var arr : [String] = []
                    if let tabData = data!["tabs"] as? [String] {
                        for dataTabObj in tabData {
                            arr.append(dataTabObj)
                            
                        }
                        arr.remove(at: 0)
                        self!.arrHeader = arr
                    }
                    var arrTableData : [TableTeamLeagueItem] = []
                    if let tableArr = data!["tableData"] as? [String : Any] {
                        if let tables = tableArr["tables"] as? [[String : Any]] {
//                            let table = tables[0]
                            for tablesObj in tables {
                                if let tableData = tablesObj["table"] as? [[String : Any]] {
                                    for tableObj in tableData {
                                        let dataTableItem = TableTeamLeagueItem()
                                        dataTableItem.draws = tableObj["draws"] as? Int
                                        dataTableItem.goalConDiff = tableObj["goalConDiff"] as? Int
                                        dataTableItem.idTeam = tableObj["idTeam"] as? Int
                                        dataTableItem.idx = tableObj["idx"] as? Int
                                        dataTableItem.losses = tableObj["losses"] as? Int
                                        dataTableItem.name = tableObj["name"] as? String
                                        dataTableItem.pageUrl = tableObj["pageUrl"] as? String
                                        dataTableItem.played = tableObj["played"] as? Int
                                        dataTableItem.pts = tableObj["pts"] as? Int
                                        dataTableItem.qualColor = tableObj["qualColor"] as? String
                                        dataTableItem.scoresStr = tableObj["scoresStr"] as? String
                                        dataTableItem.wins = tableObj["wins"] as? Int
                                        
                                        arrTableData.append(dataTableItem)
                                    }
                                    self!.dataTable = arrTableData
                                }
                            }
//                            print("hellooo",table)
                            
                        }
                    }
                    var fixturesData : [FixTuresDataModel] = []
                    if let fixtureArr = data!["fixtures"] as? [[String : Any]] {
                        for fixtureObj in fixtureArr {
                            let fixtureItem = FixTuresDataModel()
                            fixtureItem.idMatch = fixtureObj["id"] as? Int
                            fixtureItem.notStarted = fixtureObj["notStarted"] as? Bool
                            fixtureItem.pageUrl = fixtureObj["pageUrl"] as? String
                            if let statusData = fixtureObj["status"] as? [String : Any] {
                                let statusObj = StatusItemResultMatch()
                                statusObj.cancelled = statusData["cancelled"] as? Bool
                                statusObj.finished = statusData["finished"] as? Bool
                                statusObj.scoreStr = statusData["scoreStr"] as? String
                                statusObj.startDateStr = statusData["startDateStr"] as? String
                                statusObj.startTimeStr = statusData["startTimeStr"] as? String
                                statusObj.started = statusData["started"] as? Bool
                                fixtureItem.status = statusObj
                            }
                            
                            if let awayData = fixtureObj["away"] as? [String : Any] {
                                let awayObj = AwayFixturesModel()
                                awayObj.idAway = awayData["id"] as? Int
                                awayObj.name = awayData["name"] as? String
                                awayObj.score = awayData["score"] as? Int
                                fixtureItem.away = awayObj
                            }
                            if let homeData = fixtureObj["home"] as? [String : Any] {
                                let homeObj = HomeFixturesModel()
                                homeObj.idHome = homeData["id"] as? Int
                                homeObj.name = homeData["name"] as? String
                                homeObj.score = homeData["score"] as? Int
                                fixtureItem.home = homeObj
                            }
                            fixturesData.append(fixtureItem)
                        }
                        self?.fixtureData = fixturesData
                    }
                    
                    var newsArr : [NewsItem] = []
                    if let newsData = data!["news"] as? [[String : Any]] {
                        for newsDataObj in newsData {
                            let newsDataItem = NewsItem()
                            newsDataItem.imageUrl = newsDataObj["imageUrl"] as? String
                            newsDataItem.title = newsDataObj["title"] as? String
                            newsDataItem.sourceStr = newsDataObj["sourceStr"] as? String
                            newsDataItem.lead = newsDataObj["lead"] as? String
                            newsDataItem.sourceIconUrl = newsDataObj["sourceIconUrl"] as? String
                            if let pageNewsObj = newsDataObj["page"] as? [String : Any] {
                                let pageNewItem = PageNewsItem()
                                pageNewItem.url = pageNewsObj["url"] as? String
                                newsDataItem.page = pageNewItem
                            }
                            newsArr.append(newsDataItem)
                        }
                        self!.newsData = newsArr
                    }
                    
                    DispatchQueue.main.async {
                        self!.tableView.reloadData()
                        self?.nameTeam.text = self!.detailDataTeam?.name
                        self?.nameLeague.text  = self?.detailDataTeam?.country
                        self?.imageTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((self?.detailDataTeam?.idTeam)!))"), completed: nil)
                            }
                }
            }
        }
    }
}

 // tableView
extension TeamViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHeader.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTeam", for: indexPath)
        let tabsHeader  = arrHeader[indexPath.row]
        cell.textLabel?.text = tabsHeader
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrHeader[indexPath.row] == "Fixtures" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FixtureTeamViewController") as?
                FixtureTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.fixtureData = self.fixtureData
            vc?.idTeam = self.idTeam
        }else if arrHeader[indexPath.row] == "Transfers" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TransfersTeamViewController") as?
                TransfersTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            print("self.idTeam",self.idTeam)
            vc?.idTeam = self.idTeam
            vc?.nameClub = self.nameClub
        }else if arrHeader[indexPath.row] == "Table" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TableinternalLeagueTeamViewController") as?
                TableinternalLeagueTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.dataTable = self.dataTable
        }else {
//            TableinternalLeagueTeamViewController
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewsTeamViewController") as?
                NewsTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            print("self.idTeam",self.idTeam)
            vc?.newsData = self.newsData
        }
    }
}
