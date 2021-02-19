//
//  ResultMatchDetailViewController.swift
//  Football
//
//  Created by admin on 1/21/21.
//

import UIKit
import Alamofire

class ResultMatchDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    // variable
    @IBOutlet weak var timematch: UILabel!
    @IBOutlet weak var nameAwayTeam: UILabel!
    @IBOutlet weak var iconAwayTeam: UIImageView!
    @IBOutlet weak var resultMatch: UILabel!
    @IBOutlet weak var nameHomeTeam: UILabel!
    @IBOutlet weak var iconHomeTeam: UIImageView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var fourView: UIView!
    @IBOutlet weak var fiveView: UIView!
    @IBOutlet weak var sixView: UIView!
    @IBOutlet weak var sevenView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewAwayTeam: UIView!
    @IBOutlet weak var viewHomeTeam: UIView!
    var loadingView = ModalViewController()
    var dataMatchesDetail : MatchesDetailItem!
    var selectedIndexFeature : Int? = 0
    var idMatch : Int?
    var liveData = LiveTickerData()
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()        
        collectionView.showsHorizontalScrollIndicator = false // view
        dataAPI(id : idMatch!) // get API
        loadingView.showLoading() // show loading
        
        // action
        let onClickHomeTeam = UITapGestureRecognizer(target: self, action:  #selector(handleHomeTeam))
        self.viewHomeTeam.addGestureRecognizer(onClickHomeTeam)
        
        let onClickAwayTeam = UITapGestureRecognizer(target: self, action:  #selector(handleAwayTeam))
        self.viewAwayTeam.addGestureRecognizer(onClickAwayTeam)
    }
    
    
    @objc func handleAwayTeam() {
//        print("handleHomeTeam")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as?
            TeamViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.url = self.dataMatchesDetail.header?.teams![1].pageUrl
    }
    
    @objc func handleHomeTeam() {
        print("handleHomeTeam")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as?
            TeamViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.url = self.dataMatchesDetail.header?.teams![0].pageUrl
    }
    
}

// collection View
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
        selectedIndexFeature = indexPath.row
        collectionView.reloadData()
        switch self.dataMatchesDetail.nav![indexPath.row] {
        case "match facts" :
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 0
            fourView.alpha = 0
            fiveView.alpha = 0
            sixView.alpha = 0
            sevenView.alpha = 1
            break;
        case "live ticker" :
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
            fourView.alpha = 0
            fiveView.alpha = 0
            sixView.alpha = 0
            sevenView.alpha = 0
            break;
        case "stats" :
            secondView.alpha = 0
            firstView.alpha = 0
            thirdView.alpha = 1
            fourView.alpha = 0
            fiveView.alpha = 0
            sixView.alpha = 0
            sevenView.alpha = 0
            break;
        case "lineup" :
            secondView.alpha = 0
            firstView.alpha = 0
            thirdView.alpha = 0
            fourView.alpha = 1
            fiveView.alpha = 0
            sixView.alpha = 0
            sevenView.alpha = 0
            break;
        case "table" :
            secondView.alpha = 0
            firstView.alpha = 0
            thirdView.alpha = 0
            fourView.alpha = 0
            fiveView.alpha = 1
            sixView.alpha = 0
            sevenView.alpha = 0
            break;
        case "head to head" :
            secondView.alpha = 0
            firstView.alpha = 0
            thirdView.alpha = 0
            fourView.alpha = 0
            fiveView.alpha = 0
            sixView.alpha = 1
            sevenView.alpha = 0
            break;
        case "process" :
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
            fourView.alpha = 0
            fiveView.alpha = 0
            sixView.alpha = 0
            sevenView.alpha = 0
            break;
        default:
            break
        }
     }
}

// call API
extension ResultMatchDetailViewController {
    func dataAPI(id : Int) {
        let parameters : [String : Any]? = ["matchId" : id]
        let service = Connect()
        service.fetchGet(endPoint: "matchDetails",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                
                let dataMain = MatchesDetailItem()
                
                // parse Data
                if let dataApi = data {
                    DispatchQueue.global().async { [weak self] in
                        self!.parseDataNav(data: dataApi, dataMain: dataMain)
                        self!.parseDataHeader(data: dataApi, dataMain: dataMain)
                        self!.parseDataContent(data: dataApi, dataMain: dataMain)
                        self!.dataMatchesDetail = dataMain
                        // call API LiveTicker
                        if let url = self!.dataMatchesDetail.content?.liveticker?.url {
                            self!.fetchDataLiveticker(url: "https://" + url)
//                            print("contentMatch.stats",self!.dataMatchesDetail.content!.stats?.stats![0].titleType)
                        }
                        DispatchQueue.main.async {
                            self!.fillMatchesDetailData()
                            self!.collectionView.reloadData() // reload
                            self?.loadingView.hideLoading() // hide Loading
                                }
                    }
                }
                
            }
        }
    }
    
    func fetchDataLiveticker(url : String) {
        let service = Connect()
        service.getAPIUrl(url: url)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                let liveData = LiveTickerData()
                self!.fillDataLiveTicker(liveData: liveData, data: data!)
                self!.liveData = liveData
                self!.fillLiveTicker(data: self!.liveData)
            }
        }
    }
}

// fill Data to ViewController
extension ResultMatchDetailViewController {
    func fillDataLiveTicker(liveData : LiveTickerData,data : [String : Any]) {
        liveData.HometeamId = data["HometeamId"] as? Int
        liveData.AwayteamId = data["AwayteamId"] as? Int
        var eventData : [EventLiveTickerData] = []
        if let eventArr = data["Events"] as? [[String : Any]] {
            for eventObj in eventArr {
                let eventItem = EventLiveTickerData()
                eventItem.Description = eventObj["Description"] as? String
                eventItem.Elapsed = eventObj["Elapsed"] as? Int
                eventItem.HometeamEvent = eventObj["HometeamEvent"] as? Bool
                eventItem.IncidentCode = eventObj["IncidentCode"] as? String
                eventItem.ElapsedPlus = eventObj["ElapsedPlus"] as? Int
                var playerDara : [PlayersEventLiveTickerData] = []
                if let playerArr = eventObj["Players"] as? [[String : Any]] {
                    for playerObj in playerArr {
                        let playerItem  = PlayersEventLiveTickerData()
                        playerItem.Name = playerObj["Name"] as? String
                        playerItem.idPlayer = playerObj["Id"] as? Int
                        playerItem.TeamId = playerObj["TeamId"] as? Int
                        playerDara.append(playerItem)
                    }
                }
                eventItem.Players = playerDara
                eventData.append(eventItem)
            }
        }
        liveData.Events = eventData
    }
    
    func fillMatchesDetailData() {
        // fill matchFacts
        self.nameHomeTeam.text = self.dataMatchesDetail.header?.teams![0].name
        self.nameAwayTeam.text = self.dataMatchesDetail.header?.teams![1].name
        if (self.dataMatchesDetail.header?.status?.started == true) {
            self.resultMatch.text = self.dataMatchesDetail.header?.status?.scoreStr
            self.timematch.text = "Full-time"
        }else {
            self.resultMatch.text = self.dataMatchesDetail.header?.status?.startTimeStr
            self.timematch.text = self.dataMatchesDetail.header?.status?.startDateStr
        }
        
        // fill Head to Head
        if let infoHeadToHeadView = self.sixView.subviews[0].next as? HeadToHeadResultMatchViewController {
            infoHeadToHeadView.homeWin.text = String((self.dataMatchesDetail.content?.h2h?.summary![0])!)
            infoHeadToHeadView.draw.text = String((self.dataMatchesDetail.content?.h2h?.summary![1])!)
            infoHeadToHeadView.awayWin.text = String((self.dataMatchesDetail.content?.h2h?.summary![2])!)
            if let matchesData = self.dataMatchesDetail.content?.h2h?.matches {
                infoHeadToHeadView.getTableData(data : matchesData)
            }
            self.iconHomeTeam.sd_setImage(with: URL(string:("https://www.fotmob.com/" + (dataMatchesDetail.header?.teams![0].imageUrl)!)), completed: nil)
            self.iconAwayTeam.sd_setImage(with: URL(string:("https://www.fotmob.com/" + (dataMatchesDetail.header?.teams![1].imageUrl)!)), completed: nil)
        }
        
        // fill stats
        if let statsView = self.thirdView.subviews[0].next as? StatsMatchDetailViewController {
            statsView.getApi(data : (dataMatchesDetail.content?.stats)!)
        }
        
        if let matchFacts = self.sevenView.subviews[0].next as? MatchFactsssViewController {
            matchFacts.getApi(data : (dataMatchesDetail.content?.matchFacts)!)
        }
        
//        if let lineupView = self.fourView.subviews[0].next as? LineupViewController {
//            lineupView.getApi(data : (dataMatchesDetail.content?.matchFacts?.events?.events)!)
//        }

    }
    func fillLiveTicker(data : LiveTickerData) {
        if let liveTickerView = self.secondView.subviews[0].next as? LiveTickerViewController {
            liveTickerView.getDataTable(data : data)
        }
    }
}

// parse Data
extension ResultMatchDetailViewController {
    // parse Data <content Match Facts> to ViewController
    
    func parseDataNav(data : [String : Any],dataMain : MatchesDetailItem) {
        if let navArr = data["nav"] as? [String] {
            var navData : [String] = []
            for navItem in navArr {
                navData.append(navItem)
            }
            dataMain.nav = navData
        }
//        if (dataMain.header?.status?.started == true) {
//            navData.append("process")
//        }
    }
    
    func parseDataHeader(data : [String : Any],dataMain : MatchesDetailItem) {
        let headerMatchesDetailData = HeaderMatchesDetail()
        if let headerDataObj = data["header"] as? [String : Any] {
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
    }
    
    // parse Data <content> to ViewController
    func parseDataContent(data : [String : Any],dataMain : MatchesDetailItem) {
        let contentMatch = ContentmatchesDetailItem()
        if let contentData = data["content"] as? [String: Any] {
            
            // stats
            let statsData = StatsContentMatchesDetailItem()
            if let stastObj = contentData["stats"] as? [String : Any] {
                var statsChildData : [StatsOfStatsContentMatchesDetailItem] = []
                if let statsChildArr = stastObj["stats"] as? [[String : Any]] {
                    for statsChildObj in statsChildArr {
                        let statsChildItem = StatsOfStatsContentMatchesDetailItem()
                        statsChildItem.titleType = statsChildObj["title"] as? String
                        var statsParentData : [StastArrContentMatchesDetailItem] = []
                        if let statsParentArr = statsChildObj["stats"] as? [[String : Any]] {
                            for statsParentObj in statsParentArr {
                                let statsParentItem = StastArrContentMatchesDetailItem()
                                statsParentItem.titleChild = statsParentObj["title"] as? String
                                statsParentItem.highlighted = statsParentObj["highlighted"] as? String
                                statsParentItem.type = statsParentObj["type"] as? String
                                var statsItem : [String] = []
                                if let statsItemDataInt = statsParentObj["stats"] as? [Int] {
                                    for statsItemDataIntItem in statsItemDataInt {
                                        let stringStatsItem = String(statsItemDataIntItem)
                                        statsItem.append(stringStatsItem)
                                    }
//                                    statsItem.append(statsItemDataString)
                                }
                                if let statsItemDataString = statsParentObj["stats"] as? [String] {
                                    for statsItemDataStringItem in statsItemDataString {
                                        statsItem = []
                                        statsItem.append(contentsOf: statsItemDataString)
                                    }
                                }
                                statsParentItem.stats = statsItem
                                print("statsParentItem.stats",statsParentItem.stats)
                                statsParentData.append(statsParentItem)
                            }
                            statsChildItem.stats = statsParentData
                        }
                        statsChildData.append(statsChildItem)
                    }
                    statsData.stats = statsChildData
                }
            }
            contentMatch.stats = statsData

            // table
            let table = TableContentMatchesDetailItem()
            if let tableData = contentData["table"] as? [String : Any] {
                table.url = tableData["url"] as? String
                contentMatch.table = table
            }
            
            // match facts
            let matchFacts = MatchFactsContentMatchesDetailItem()
            if let matchFactsData = contentData["matchFacts"] as? [String : Any] {
                let matchFactsHighlightsItem = HighLightsMatchFactsContentMatchesDetailItem()
                if let matchFactsHighlights = matchFactsData["highlights"] as? [String : Any] {
                    matchFactsHighlightsItem.image = matchFactsHighlights["image"] as? String
                    matchFactsHighlightsItem.source = matchFactsHighlights["source"] as? String
                    matchFactsHighlightsItem.url = matchFactsHighlights["url"] as? String
                }
                if matchFactsData["highlights"] == nil {
                    matchFacts.highlights = nil
                }else {
                    matchFacts.highlights = matchFactsHighlightsItem
                }
                
                
                let eventParent = EventsMatchFactsContentMatchesDetailItem()
                if let eventParentData = matchFactsData["events"] as? [String : Any] {
                    eventParent.ongoing = eventParentData["ongoing"] as? Bool
                    var eventChild : [EventsOfEventsMatchFactsContentMatchesDetailItem] = []
                    if let eventChildArr = eventParentData["events"] as? [[String : Any]] {
                        for eventChildObj in eventChildArr {
                             let eventChildItem = EventsOfEventsMatchFactsContentMatchesDetailItem()
                            eventChildItem.card = eventChildObj["card"] as? String
                            eventChildItem.isHome = eventChildObj["isHome"] as? Bool
                            eventChildItem.nameStr = eventChildObj["nameStr"] as? String
                            eventChildItem.overloadTimeStr = eventChildObj["overloadTimeStr"] as? Bool
                            eventChildItem.profileUrl = eventChildObj["profileUrl"] as? String
                            eventChildItem.reactKey = eventChildObj["reactKey"] as? String
                            eventChildItem.time = eventChildObj["time"] as? Int
                            eventChildItem.timeStr = eventChildObj["timeStr"] as? String
                            eventChildItem.type = eventChildObj["type"] as? String
                            eventChild.append(eventChildItem)
                        }
                    }
                    eventParent.events = eventChild
                }
                matchFacts.events = eventParent

                let playerOfTheMatch = PlayerOfTheMatchMatchFactsContentMatchesDetailItem()
                if let playerOfTheMatchData = matchFactsData["playerOfTheMatch"] as? [String : Any] {
                    playerOfTheMatch.idPlayerOfTheMatch = playerOfTheMatchData["id"] as? Int
                    playerOfTheMatch.pageUrl = playerOfTheMatchData["pageUrl"] as? String
                    playerOfTheMatch.role = playerOfTheMatchData["role"] as? String
                    playerOfTheMatch.teamId = playerOfTheMatchData["teamId"] as? Int
                    playerOfTheMatch.teamName = playerOfTheMatchData["teamName"] as? String
                    let namePlayerOfTheMatch = NamePlayerOfTheMatchMatchFactsContentMatchesDetailItem()
                    if let namePlayerOfTheMatchData = playerOfTheMatchData["name"] as? [String : Any] {
                        namePlayerOfTheMatch.firstName = namePlayerOfTheMatchData["firstName"] as? String
                        namePlayerOfTheMatch.lastName = namePlayerOfTheMatchData["lastName"] as? String
                    }
                    playerOfTheMatch.name = namePlayerOfTheMatch
                    let ratingPlayerData = RatingPlayerOfTheMatchMatchFactsContentMatchesDetailItem()
                    if let ratingPlayer = playerOfTheMatchData["rating"] as? [String : Any] {
                        ratingPlayerData.num = ratingPlayer["num"] as? String
                    }
                    playerOfTheMatch.rating = ratingPlayerData
                    
                    if playerOfTheMatchData.isEmpty {
                        matchFacts.playerOfTheMatch = nil
                        print("day ne")
                    }else {
                        matchFacts.playerOfTheMatch = playerOfTheMatch
                    }
                    
                }
                
                
                let infoBox = InfoBoxMatchFactsContentMatchesDetailItem()
                if let infoBoxData = matchFactsData["infoBox"] as? [String : Any] {
                    infoBox.matchDate = infoBoxData["Match Date"] as? String
                    let referee = RefereeMatchFactsContentMatchesDetailItem()
                    if let refereeData = infoBoxData["Referee"] as? [String : Any] {
                        referee.imgUrl = refereeData["imgUrl"] as? String
                        referee.textReferee = refereeData["text"] as? String
                    }
                    infoBox.Referee = referee
                    
                    let stadium = StadiumMatchFactsContentMatchesDetailItem()
                    if let stadiumData = infoBoxData["Stadium"] as? [String : Any] {
                        stadium.name = stadiumData["name"] as? String
                    }
                    infoBox.Stadium = stadium
                    
                    let tournament = TournamentMatchFactsContentMatchesDetailItem()
                    if let tournamentData = infoBoxData["Tournament"] as? [String : Any] {
                        tournament.idTournament = tournamentData["id"] as? Int
                        tournament.link = tournamentData["link"] as? String
                        tournament.textTournament = tournamentData["text"] as? String
                    }
                    infoBox.Tournament = tournament
                }
                matchFacts.infoBox = infoBox
            }
            contentMatch.matchFacts = matchFacts
            
            
            // liveTicker
            let liveticker = LivetickerContentMatchesDetailItem()
            if let livetickerData = contentData["liveticker"] as? [String : Any] {
                liveticker.showSuperLive = livetickerData["showSuperLive"] as? Bool
                liveticker.url = livetickerData["url"] as? String
                var teamArr : [String] = []
                if let teamData = livetickerData["teams"] as? [String] {
                    for teamItem in teamData {
                        teamArr.append(teamItem)
                    }
                    liveticker.teams = teamArr
                }
            }
            contentMatch.liveticker = liveticker
            
            
            // head to head
            let contentH2hMatch = HeadToHeadContentMatchesDetailItem()
            if let h2hContentData = contentData["h2h"] as? [String : Any] {
                var SummaryH2hArr : [Int] = []
                if let summaryH2hContentData = h2hContentData["summary"] as? [Int] {
                    for summaryH2hContentDataItem in summaryH2hContentData {
                        SummaryH2hArr.append(summaryH2hContentDataItem)
                    }
                    contentH2hMatch.summary = SummaryH2hArr
                }
                var matchH2hArr : [MatchHeadToHeadContentMatchesDetailItem] = []
                if let matchesH2hData = h2hContentData["matches"] as? [[String : Any]] {
                    for matchesH2hDataOnj in matchesH2hData {
                        let matchesH2hDataItem = MatchHeadToHeadContentMatchesDetailItem()
                        matchesH2hDataItem.time = matchesH2hDataOnj["time"] as? String
                        matchesH2hDataItem.finished = matchesH2hDataOnj["finished"] as? Bool
                        matchesH2hDataItem.matchUrl = matchesH2hDataOnj["matchUrl"] as? String
                        if let leagueMatchH2hData = matchesH2hDataOnj["league"] as? [String: Any] {
                            let leagueMatchH2hDataObj = LeagueHeadToHeadContentMatchesDetailItem()
                            leagueMatchH2hDataObj.name = leagueMatchH2hData["name"] as? String
                            leagueMatchH2hDataObj.pageUrl = leagueMatchH2hData["pageUrl"] as? String
                            matchesH2hDataItem.league = leagueMatchH2hDataObj
                        }
                        if let homeMatchH2hData = matchesH2hDataOnj["home"] as? [String : Any] {
                            let homeMatchH2hDataObj = InfoHeadToHeadContentMatchesDetailItem()
                            homeMatchH2hDataObj.idTeam = homeMatchH2hData["id"] as? String
                            homeMatchH2hDataObj.name = homeMatchH2hData["name"] as? String
                            matchesH2hDataItem.home = homeMatchH2hDataObj
                        }
                        if let awayMatchH2hData = matchesH2hDataOnj["away"] as? [String : Any] {
                            let awayMatchH2hDataObj = InfoHeadToHeadContentMatchesDetailItem()
                            awayMatchH2hDataObj.idTeam = awayMatchH2hData["id"] as? String
                            awayMatchH2hDataObj.name = awayMatchH2hData["name"] as? String
                            matchesH2hDataItem.away = awayMatchH2hDataObj
                        }
                        if let statusMatchH2hData = matchesH2hDataOnj["status"] as? [String : Any] {
                            let statusMatchH2hObj = StatusItemResultMatch()
                            statusMatchH2hObj.finished = statusMatchH2hData["finished"] as? Bool
                            statusMatchH2hObj.started = statusMatchH2hData["started"] as? Bool
                            statusMatchH2hObj.cancelled = statusMatchH2hData["cancelled"] as? Bool
                            statusMatchH2hObj.scoreStr = statusMatchH2hData["scoreStr"] as? String
                            statusMatchH2hObj.startDateStr = statusMatchH2hData["startDateStr"] as? String
                            statusMatchH2hObj.startTimeStr = statusMatchH2hData["startTimeStr"] as? String
                            matchesH2hDataItem.status = statusMatchH2hObj
                        }
                        matchH2hArr.append(matchesH2hDataItem)
                    }
                }
                contentH2hMatch.matches = matchH2hArr
            }
            contentMatch.h2h = contentH2hMatch
            
        }
        dataMain.content = contentMatch
    }
    
    
}

