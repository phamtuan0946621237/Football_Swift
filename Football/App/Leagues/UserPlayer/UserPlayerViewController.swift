//
//  UserPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class UserPlayerViewController: UIViewController {
    //variable
    var idPlayer : Int?
    var dataInfoPlayer : InfoPlayerItemObj?
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    var infoUser = InfoPlayerViewController()
    var carrerPlayerInfo = CareerPlayerViewController()
    var newsPlayerInfo = NewsPlayerViewController()
    
    // main
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataUserPlayer(id: idPlayer!) // call API
    }
}

// action
extension UserPlayerViewController {
    @IBAction func switchView(_ sender: UISegmentedControl) {
        print("hhhhhhh",sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 1
            
        }else if  sender.selectedSegmentIndex == 1{
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
        }
    }
}


extension UserPlayerViewController {
    // fetch Api
    func fetchDataUserPlayer(id : Int) {
        let parameters : [String : Any]? = ["id" : id]
        let service = Connect()
        service.fetchGet(endPoint: "playerData",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                if let dataObj = data {
                    self!.parseDataApi(dataObj : dataObj) // parse Data
                    self!.infoUser.getData(data : self!.dataInfoPlayer!)
                    self!.newsPlayerInfo.getData(data : self!.dataInfoPlayer!)
                }
            }
        }
    }
    
    // parse Data to Modal
    func parseDataApi(dataObj : [String : Any]) {
        let dataItem = InfoPlayerItemObj()
        dataItem.name = dataObj["name"] as? String
        dataItem.idPlayer = dataObj["id"] as? Int
        if let dataOriginObj = dataObj["origin"] as? [String : Any] {
            let dataOriginItem = OriginInfoPlayer()
            dataOriginItem.teamName = dataOriginObj["teamName"] as? String
            dataOriginItem.teamId = dataOriginObj["teamId"] as? Int
            if let positionDescObj = dataOriginObj["positionDesc"] as? [String : Any] {
                let positionDescItem = PositionDescInfoPlayer()
                positionDescItem.nonPrimaryPositions = positionDescObj["nonPrimaryPositions"] as? String
                positionDescItem.primaryPosition = positionDescObj["primaryPosition"] as? String
                dataOriginItem.positionDesc = positionDescItem
            }
            dataItem.origin = dataOriginItem
        }
        var playerPropsArr : [InfoPlayerDataItem] = []
        if let playerPropsObj = dataObj["playerProps"] as? [[String : Any]] {
            for obj in playerPropsObj {
                let playerPropsItem = InfoPlayerDataItem()
                playerPropsItem.value = obj["value"] as? String
                playerPropsItem.title = obj["title"] as? String
                playerPropsArr.append(playerPropsItem)
            }
        }
        dataItem.playerProps = playerPropsArr
        var relatedNewsArr : [NewsItem] = []
        if let relatedNews = dataObj["relatedNews"] as? [[String : Any]] {
            for relatedNewsObj in relatedNews {
                let relatedNewsItem = NewsItem()
                relatedNewsItem.imageUrl = relatedNewsObj["imageUrl"] as? String
                relatedNewsItem.lead = relatedNewsObj["lead"] as? String
                relatedNewsItem.sourceIconUrl = relatedNewsObj["sourceIconUrl"] as? String
                relatedNewsItem.sourceStr = relatedNewsObj["sourceStr"] as? String
                relatedNewsItem.title = relatedNewsObj["title"] as? String
                if let page = relatedNewsObj["page"] as? [String : Any] {
                    let pageObj = PageNewsItem()
                    pageObj.url = page["url"] as? String
                    relatedNewsItem.page = pageObj
                }
                relatedNewsArr.append(relatedNewsItem)
            }
        }
        dataItem.relatedNews = relatedNewsArr
        let careerItemsObj = CareerInfoPlayer()
        if let careerHistory = dataObj["careerHistory"] as? [String : Any] {
            if let careerData = careerHistory["careerData"] as? [String : Any] {
                if let careerItems = careerData["careerItems"] as? [String : Any] {
                    var nationalteamArr : [CareerPlayerDetailInfo] = []
                    var seniorArr : [CareerPlayerDetailInfo] = []
                    if let nationalteam = careerItems["national team"] as? [[String : Any]] {
                            for nationalteamObj in nationalteam {
                                let nationalteamItem = CareerPlayerDetailInfo()
                                nationalteamItem.appearances = nationalteamObj["appearances"] as? String
                                nationalteamItem.endDate = nationalteamObj["endDate"] as? String
                                nationalteamItem.goals = nationalteamObj["goals"] as? String
                                nationalteamItem.hasUncertainData = nationalteamObj["hasUncertainData"] as? Bool
                                nationalteamItem.participantId = nationalteamObj["participantId"] as? Int
                                nationalteamItem.startDate = nationalteamObj["startDate"] as? String
                                nationalteamItem.team = nationalteamObj["team"] as? String
                                nationalteamItem.teamId = nationalteamObj["teamId"] as? Int
                                nationalteamArr.append(nationalteamItem)
                            }
                    }
                    if let senior = careerItems["senior"] as? [[String : Any]] {
                            for seniorObj in senior {
                                let nationalteamItem = CareerPlayerDetailInfo()
                                nationalteamItem.appearances = seniorObj["appearances"] as? String
                                nationalteamItem.endDate = seniorObj["endDate"] as? String
                                nationalteamItem.goals = seniorObj["goals"] as? String
                                nationalteamItem.hasUncertainData = seniorObj["hasUncertainData"] as? Bool
                                nationalteamItem.participantId = seniorObj["participantId"] as? Int
                                nationalteamItem.startDate = seniorObj["startDate"] as? String
                                nationalteamItem.team = seniorObj["team"] as? String
                                nationalteamItem.teamId = seniorObj["teamId"] as? Int
                                seniorArr.append(nationalteamItem)
                            }
                    }
                    careerItemsObj.nationalteam = nationalteamArr
                    careerItemsObj.senior = seniorArr
                }
            }
        }
        dataItem.careerItems = careerItemsObj
        self.dataInfoPlayer = dataItem
    }
}
