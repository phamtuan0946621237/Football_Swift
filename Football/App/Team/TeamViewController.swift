//
//  TeamViewController.swift
//  Football
//
//  Created by admin on 2/17/21.
//

import UIKit

class TeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var nameLeague: UILabel!
    
    @IBOutlet weak var imageTeam: UIImageView!
    var fixtureData : [FixTuresDataModel] = []
    var newsData : [NewsItem] = []
    var url : String! = nil
//    var teamData : TeamModelItemData?
    var arrHeader : [String] = []
    var detailDataTeam : DetailTeamModelItemData?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAPI(url: self.url)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func dataAPI(url : String) {
        let service = Connect()
        service.getAPIUrl(url: "https://www.fotmob.com/teams?id=8634&tab=overview&type=team&timeZone=Asia%2FSaigon&seo=barcelona")
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
                    if let tabData = data!["tabs"] as? [String] {
                        for dataTabObj in tabData {
                            self!.arrHeader.append(dataTabObj)
                        }
                        print("arrHeader",self!.arrHeader)
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
//                        print("self?.fixtureData",self?.fixtureData[0].away?.name)
//                        print("self?.fixtureData",self?.fixtureData[0].home?.name)
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
                        print("self.detailDataTeam",self!.detailDataTeam?.name)
                        self?.nameTeam.text = self!.detailDataTeam?.name
                        self?.nameLeague.text  = self?.detailDataTeam?.country
                        self?.imageTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((self?.detailDataTeam?.idTeam)!))"), completed: nil)
                            }
                }
            }
        }
    }
    
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
            vc?.idTeam = 8634
        }else if arrHeader[indexPath.row] == "Transfers" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TransfersTeamViewController") as?
                TransfersTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.idTeam = 8634
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewsTeamViewController") as?
                NewsTeamViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
            vc?.newsData = self.newsData
        }
//
    }
}
