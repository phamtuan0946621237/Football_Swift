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
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var four: UIView!
    var loadingView = ModalViewController()
    // main
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDataUserPlayer(id: idPlayer!)
        self.title = "Info Player"
        loadingView.showLoading()
    }
}

// action
extension UserPlayerViewController {
    @IBAction func switchView(_ sender: UISegmentedControl)   {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 0
            secondView.alpha = 0
            four.alpha = 1
        }else if  sender.selectedSegmentIndex == 1{
            firstView.alpha = 1
            secondView.alpha = 0
            four.alpha = 0
        } else {
            firstView.alpha = 0
            secondView.alpha = 1
            four.alpha = 0
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
                    self!.parseDataApiToModel(dataObj : dataObj) // parse Data
                    self!.fillDataToView()
                    self!.loadingView.hideLoading()
                }
            }
        }
    }
    
    // fill data to View
    func fillDataToView() {
        if let infoPlayerView = self.four.subviews[0].next as? InfoMemberViewController {
            infoPlayerView.hello.titleLabel.text = self.dataInfoPlayer!.name
            infoPlayerView.hello.valueHeight.text = self.dataInfoPlayer!.playerProps![0].value as? String
            infoPlayerView.hello.valuePrefer.text = self.dataInfoPlayer!.playerProps![1].value as? String
            if self.dataInfoPlayer != nil && self.dataInfoPlayer!.playerProps != nil &&  (self.dataInfoPlayer!.playerProps![2].value != nil)  {
                infoPlayerView.hello.valueAge.text = String((self.dataInfoPlayer!.playerProps![2].value! as? Int)!)
            }
            infoPlayerView.hello.valueCountry.text = self.dataInfoPlayer!.playerProps![3].value as? String
            infoPlayerView.hello.valueMarket.text = self.dataInfoPlayer!.playerProps![5].value as? String
            infoPlayerView.hello.mainPosition.text = self.dataInfoPlayer!.origin?.positionDesc?.primaryPosition
            infoPlayerView.hello.otherPosition.text = self.dataInfoPlayer!.origin?.positionDesc?.nonPrimaryPositions
            infoPlayerView.hello.nameLeague.text = self.dataInfoPlayer!.lastLeague?.leagueName
            infoPlayerView.hello.valuematches.text = self.dataInfoPlayer!.lastLeague?.playerProps![0].value
            infoPlayerView.hello.valueGoals.text = self.dataInfoPlayer!.lastLeague?.playerProps![1].value
            infoPlayerView.hello.valueAssist.text = self.dataInfoPlayer!.lastLeague?.playerProps![2].value
            infoPlayerView.hello.valueRating.text = self.dataInfoPlayer!.lastLeague?.playerProps![3].value
            infoPlayerView.hello.nameClub.text = self.dataInfoPlayer!.origin?.teamName
            infoPlayerView.hello.iconClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((self.dataInfoPlayer!.origin?.teamId!)!))"), completed: nil)
            infoPlayerView.hello.iconLeague.sd_setImage(with: URL(string: "https://www.fotmob.com/images/league/\(String((self.dataInfoPlayer!.lastLeague?.leagueId!)!))"), completed: nil)
            infoPlayerView.hello.iconPlayer.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String((self.dataInfoPlayer!.idPlayer!))).png"), completed: nil)
        }
        
        if let careerPlayerView = self.firstView.subviews[0].next as? CareerPlayerViewController {
            careerPlayerView.titleCareer.text = "Career"
            careerPlayerView.getData(data: (self.dataInfoPlayer?.careerItems)!)
        }
        
        if let newsPlayerView = self.secondView.subviews[0].next as? NewsPlayerViewController {
            newsPlayerView.getData(data: (self.dataInfoPlayer?.relatedNews)!)
        }
    }
    
    
    // parse Data to Modal
    func parseDataApiToModel(dataObj : [String : Any]) {
        let dataItem = InfoPlayerItemObj()
        dataItem.name = dataObj["name"] as? String
        dataItem.idPlayer = dataObj["id"] as? Int
        if let dataLastLeagueObj = dataObj["lastLeague"] as? [String : Any] {
            let dataLastLeagueItem = LastLeagueInfoPlayerItem()
            dataLastLeagueItem.leagueId = dataLastLeagueObj["leagueId"] as? Int
            dataLastLeagueItem.leagueName = dataLastLeagueObj["leagueName"] as? String
            var playerPropsData : [playerPropsLastLeagueInfoPlayer] = []
            if let playerPropsArray = dataLastLeagueObj["playerProps"] as? [[String : Any]] {
                for playerPropsobj in playerPropsArray {
                    let playerPropsItem = playerPropsLastLeagueInfoPlayer()
                    playerPropsItem.title = playerPropsobj["title"] as? String
                    playerPropsItem.value = playerPropsobj["value"] as? String
                    playerPropsData.append(playerPropsItem)
                }
            }
            dataLastLeagueItem.playerProps = playerPropsData
            dataItem.lastLeague = dataLastLeagueItem
        }
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
