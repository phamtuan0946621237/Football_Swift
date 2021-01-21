//
//  ResultMatchDetailViewController.swift
//  Football
//
//  Created by admin on 1/21/21.
//

import UIKit

class ResultMatchDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var timematch: UILabel!
    var idMatch : Int?
    @IBOutlet weak var nameAwayTeam: UILabel!
    @IBOutlet weak var iconAwayTeam: UIImageView!
    @IBOutlet weak var resultMatch: UILabel!
    @IBOutlet weak var nameHomeTeam: UILabel!
    @IBOutlet weak var iconHomeTeam: UIImageView!
    @IBOutlet weak var first: UIView!
    @IBOutlet weak var third: UIView!
    @IBOutlet weak var second: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var six: UIView!
    @IBOutlet weak var five: UIView!
    @IBOutlet weak var seven: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var loadingView = ModalViewController()
    var dataMatchesDetail : MatchesDetailItem!
//    let data = ["match fats","process","live ticker","stats","lineup","table","head to head"]
    var selectedIndexFeature : Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("idMatch",idMatch)
        collectionView.showsHorizontalScrollIndicator = false
        dataAPI(id : idMatch!)
        loadingView.showLoading()
        // Do any additional setup after loading the view.
    }

}

extension ResultMatchDetailViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.dataMatchesDetail != nil {
            return self.dataMatchesDetail.nav!.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureMatchesDetailCollectionViewCell", for: indexPath) as! FeatureMatchesDetailCollectionViewCell
        
        let dataCollection = self.dataMatchesDetail != nil ? self.dataMatchesDetail.nav : ["hello"]
            cell.title.text = dataCollection![indexPath.row]
            if self.selectedIndexFeature == indexPath.row {
                cell.title.textColor = UIColor.red
            }else {
                cell.title.textColor = UIColor.black
            }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index : ",indexPath.row)
        
        selectedIndexFeature = indexPath.row
        collectionView.reloadData()
        switch indexPath.row {
        case 0:
            first.alpha = 0
            second.alpha = 0
            third.alpha = 0
            four.alpha = 0
            five.alpha = 0
            six.alpha = 0
            seven.alpha = 1
            break;
        case 1:
            first.alpha = 1
            second.alpha = 0
            third.alpha = 0
            four.alpha = 0
            five.alpha = 0
            six.alpha = 0
            seven.alpha = 0
            break;
        case 2:
            first.alpha = 0
            second.alpha = 1
            third.alpha = 0
            four.alpha = 0
            five.alpha = 0
            six.alpha = 0
            seven.alpha = 0
            break;
        case 3:
            first.alpha = 0
            second.alpha = 0
            third.alpha = 1
            four.alpha = 0
            five.alpha = 0
            six.alpha = 0
            seven.alpha = 0
            break;
        case 4:
            first.alpha = 0
            second.alpha = 0
            third.alpha = 0
            four.alpha = 0
            five.alpha = 1
            six.alpha = 0
            seven.alpha = 0
            break;
        case 5:
            first.alpha = 0
            second.alpha = 0
            third.alpha = 0
            four.alpha = 0
            five.alpha = 0
            six.alpha = 1
            seven.alpha = 0
        case 6:
            first.alpha = 0
            second.alpha = 0
            third.alpha = 0
            four.alpha = 1
            five.alpha = 0
            six.alpha = 0
            seven.alpha = 0
            break;
        default:
            break;
        }
     }
    
}


extension ResultMatchDetailViewController {
    func dataAPI(id : Int) {
        let parameters : [String : Any]? = ["matchId" : id]
        let service = Connect()
        service.fetchGet(endPoint: "matchDetails",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
//                print("gggggg : ",data)
                let dataMain = MatchesDetailItem()
                if let navArr = data!["nav"] as? [String] {
                    var navData : [String] = []
                    for navItem in navArr {
                        navData.append(navItem)
                    }
                    
                    let headerMatchesDetailData = HeaderMatchesDetail()
                    if let headerDataObj = data!["header"] as? [String : Any] {
                        if let StatusheaderDataObj = headerDataObj["status"] as? [String : Any] {
                            let statusHeaderDataItem = StatusHeaderMatchesDetail()
                            statusHeaderDataItem.cancelled = StatusheaderDataObj["cancelled"] as? Bool
                            statusHeaderDataItem.finished = StatusheaderDataObj["finished"] as? Bool
                            statusHeaderDataItem.scoreStr = StatusheaderDataObj["scoreStr"] as? String
                            statusHeaderDataItem.startDateStr = StatusheaderDataObj["startDateStr"] as? String
                            statusHeaderDataItem.startTimeStr = StatusheaderDataObj["startTimeStr"] as? String
                            statusHeaderDataItem.started = StatusheaderDataObj["started"] as? Bool
                            statusHeaderDataItem.whoLostOnAggregated = StatusheaderDataObj["whoLostOnAggregated"] as? String
                            headerMatchesDetailData.status = statusHeaderDataItem
                        }
                        var teamsHeaderData : [TeamsHeaderMatchesDetail] = []
                        if let teamsHeaderDataArr = headerDataObj["teams"] as? [[String : Any]] {
                            for teamsHeaderDataObj in teamsHeaderDataArr {
                                let teamsHeaderDataItem = TeamsHeaderMatchesDetail()
                                teamsHeaderDataItem.imageUrl = teamsHeaderDataObj["imageUrl"] as? String
                                teamsHeaderDataItem.name = teamsHeaderDataObj["name"] as? String
                                teamsHeaderDataItem.pageUrl = teamsHeaderDataObj["pageUrl"] as? String
                                teamsHeaderDataItem.score = teamsHeaderDataObj["score"] as? Int
                                teamsHeaderData.append(teamsHeaderDataItem)
                                
                            }
                        }
                        headerMatchesDetailData.teams = teamsHeaderData
                    }
                    
                    
                    dataMain.header = headerMatchesDetailData
                    if (dataMain.header?.status?.started == true) {
                        navData.append("process")
                    }
                    dataMain.nav = navData
                    self!.dataMatchesDetail = dataMain
                    print("dataMain.nav",self!.dataMatchesDetail.header?.teams![0].imageUrl)
                    self!.collectionView.reloadData()
                    self!.nameHomeTeam.text = self!.dataMatchesDetail.header?.teams![0].name
                    self!.nameAwayTeam.text = self!.dataMatchesDetail.header?.teams![1].name
                    if (self!.dataMatchesDetail.header?.status?.started == true) {
                        self!.resultMatch.text = self!.dataMatchesDetail.header?.status?.scoreStr
                        self!.timematch.text = "Full-time"
                    }else {
                        self!.resultMatch.text = self!.dataMatchesDetail.header?.status?.startTimeStr
                        self!.timematch.text = self!.dataMatchesDetail.header?.status?.startDateStr
                    }
                    
//                    self!.iconHomeTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/9879_small"), completed: nil)
//                    self!.iconAwayTeam.sd_setImage(with: URL(string: "https://www.fotmob.com\(self!.dataMatchesDetail.header?.teams![1].imageUrl)"), completed: nil)
                    
                        
                    
                    self!.collectionView.reloadData()
                    self?.loadingView.hideLoading()
                }
            }
        }
    }
}
