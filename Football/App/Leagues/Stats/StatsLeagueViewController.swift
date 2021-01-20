//
//  StatsLeagueViewController.swift
//  Football
//
//  Created by admin on 1/18/21.
//

import UIKit

class StatsLeagueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var tableView: UITableView!
    var selectedSegmentIndex = 0
    var dataStats : StatsItem?
    var seo : String?
    var idLeague : Int?
    let loadingView = ModalViewController()
    
    // main life
    override func viewDidLoad() {
        super.viewDidLoad()
        getView() // getView
        self.dataAPI(id: idLeague!, seo: seo!) // call Api
        loadingView.showLoading() // show loading
    }
}

// View
extension StatsLeagueViewController {
    func getView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "StatLeagueItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "StatLeagueItemTableViewCell")
    }
}

// action
extension StatsLeagueViewController {
    @IBAction func onChangeSegment(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        tableView.reloadData()
    }
}

// tableView
extension StatsLeagueViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (selectedSegmentIndex == 0 && dataStats?.stats?.player?[section].topThree != nil) {
            return (dataStats?.stats?.player?[section].topThree!.count)!
        }
        if (selectedSegmentIndex == 1 && dataStats?.stats?.team?[section].topThree != nil) {
            return (dataStats?.stats?.team?[section].topThree!.count)!
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatLeagueItemTableViewCell", for: indexPath) as? StatLeagueItemTableViewCell
        let sectionData = selectedSegmentIndex == 0 ? dataStats?.stats?.player![indexPath.section] : dataStats?.stats?.team![indexPath.section]
        let tableCellData = sectionData?.topThree![indexPath.row]
        cell!.name.text = tableCellData?.name

        cell!.stt.text =  selectedSegmentIndex == 0 ? String(format: "%d", tableCellData?.value ?? "hello") : nil
        if selectedSegmentIndex == 0 {
            cell?.icon.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String(tableCellData!.idPlayer!)).png"), completed: nil)
        }else {
            cell?.icon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(tableCellData!.teamId!))"), completed: nil)
        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemGray6
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
        titleLabel.textColor = .black
        titleLabel.text = selectedSegmentIndex == 0 ? dataStats?.stats?.player![section].header : dataStats?.stats?.team![section].header
            view.addSubview(titleLabel)
            return view
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if selectedSegmentIndex == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ListStatsFilterViewController") as?
                ListStatsFilterViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            vc?.typeStats = dataStats?.stats?.player![indexPath.section].header
            vc?.idLeague = self.idLeague
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (selectedSegmentIndex == 0 && dataStats?.stats?.player != nil) {
            return (dataStats?.stats?.player!.count)!
        }
        if (selectedSegmentIndex == 1 && dataStats?.stats?.team != nil) {
            return (dataStats?.stats?.team!.count)!
        }
        return 0
    }
}

// call Api
extension StatsLeagueViewController {
    func dataAPI(id : Int,seo : String) {
        let parameters : [String : Any]? = ["id" : id,"tab" : "stats","type" : "league","timeZone" : "Asia%2FSaigon","seo" : seo]
        let service = Connect()
        service.fetchGet(endPoint: "leagues",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                let detailLeagueInfo = StatsItem()
                if let tableDataObj = data!["stats"] as? [String : Any] {
                    let StatsLeaguesItem = StatsItemsType()
                    
                    // convert players Model
                    if let StatsItemsTypeArr = tableDataObj["players"] as? [[String : Any]] {
                        var PlayerArray : [StatsLeagueItem] = []
                        for tablesObj in StatsItemsTypeArr {
                            let tablesItem = StatsLeagueItem()
                            tablesItem.header = tablesObj["header"] as? String
                            var topThreePlayerStatsArr : [TopThreeStatsItem] = []
                            PlayerArray.append(tablesItem)
                            if let topThreePlayerStatsArray = tablesObj["topThree"] as? [[String : Any]] {
                                for TopThreePlayerStatsItem in topThreePlayerStatsArray {
                                    let TopThreePlayerStatsObj = TopThreeStatsItem()
                                    TopThreePlayerStatsObj.name = TopThreePlayerStatsItem["name"] as? String
                                    TopThreePlayerStatsObj.idPlayer = TopThreePlayerStatsItem["id"] as? Int
                                    TopThreePlayerStatsObj.showTeamFlag = TopThreePlayerStatsItem["showTeamFlag"] as? Bool
                                    TopThreePlayerStatsObj.teamId = TopThreePlayerStatsItem["teamId"] as? Int
                                    TopThreePlayerStatsObj.teamName = TopThreePlayerStatsItem["teamName"] as? String
                                    TopThreePlayerStatsObj.value = TopThreePlayerStatsItem["value"] as? Int
                                    topThreePlayerStatsArr.append(TopThreePlayerStatsObj)
                                }
                            }
                            
                            tablesItem.topThree = topThreePlayerStatsArr
                    }
                        StatsLeaguesItem.player = PlayerArray
                }
                    
                    // convert Teams Model
                    if let StatsItemsTypeArr = tableDataObj["teams"] as? [[String : Any]] {
                        var TeamArray : [StatsLeagueItem] = []
                        for tablesObj in StatsItemsTypeArr {
                            let tablesItem = StatsLeagueItem()
                            tablesItem.header = tablesObj["header"] as? String
                            var topThreePlayerStatsArr : [TopThreeStatsItem] = []
                            TeamArray.append(tablesItem)
                            if let topThreePlayerStatsArray = tablesObj["topThree"] as? [[String : Any]] {
                                for TopThreePlayerStatsItem in topThreePlayerStatsArray {
                                    let TopThreePlayerStatsObj = TopThreeStatsItem()
                                    TopThreePlayerStatsObj.name = TopThreePlayerStatsItem["name"] as? String
                                    TopThreePlayerStatsObj.idPlayer = TopThreePlayerStatsItem["id"] as? Int
                                    TopThreePlayerStatsObj.showTeamFlag = TopThreePlayerStatsItem["showTeamFlag"] as? Bool
                                    TopThreePlayerStatsObj.teamId = TopThreePlayerStatsItem["teamId"] as? Int
                                    TopThreePlayerStatsObj.teamName = TopThreePlayerStatsItem["teamName"] as? String
                                    TopThreePlayerStatsObj.value = TopThreePlayerStatsItem["value"] as? Int
                                    topThreePlayerStatsArr.append(TopThreePlayerStatsObj)
                                }
                            }
                            tablesItem.topThree = topThreePlayerStatsArr
                    }
                        StatsLeaguesItem.team = TeamArray
                }
                    detailLeagueInfo.stats = StatsLeaguesItem
                self?.dataStats = detailLeagueInfo
                self!.loadingView.hideLoading()
                self?.tableView.reloadData()
            }
        }
    }
}
}
