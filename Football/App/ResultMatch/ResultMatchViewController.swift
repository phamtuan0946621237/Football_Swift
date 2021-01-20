//
//  ResultMatchViewController.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import UIKit
import Loading
class ResultMatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    var dataMatch : [ResultMatchItem] = []
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let height : CGFloat = 250
    @IBOutlet weak var inputSelectedDate: UITextField!
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let loadingView = ModalViewController()
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // set tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListResultMatchTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListResultMatchTableViewCell")
        // get view
            getMainView()
        // initial
            datePicker.date = Date()
        // conver Date to String
            self.dateFormatter.dateFormat = "yyyy-MM-dd"
            var date = dateFormatter.string(from: datePicker.date)
        
            dataAPI(date: getDate(dateAsString: date))// call APi
        
        // show Loading
//        ModalViewController.showLoading()
        self.loadingView.showLoading()
    }
//    func delay(seconds : Double,)
}

// view
extension ResultMatchViewController {
    // main View
    func getMainView() {
        customView()
        createDatePicker()
        self.hideKeyboardWhenTappedAround()
    }
    // custom View
    func customView() {
        datePicker.backgroundColor = .systemGray6
        let screenSize = UIScreen.main.bounds.size
        datePicker.frame = CGRect(x: 0, y: 100, width: screenSize.width, height: 100)
    }
    // input Date
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: false)
        inputSelectedDate.inputAccessoryView = toolbar
        inputSelectedDate.inputView = datePicker
        datePicker.datePickerMode = .date
        
    }
    @objc func donePressed() {
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateAsString = dateFormatter.string(from: datePicker.date)
        inputSelectedDate.text = "\(dateAsString)" // view
        // call API
        self.dataMatch = []
        dataAPI(date: getDate(dateAsString: dateAsString))
        
        self.view.endEditing(true)
    }
    
    // dismis keyboard
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ResultMatchViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// fetch Data
extension ResultMatchViewController {
    func dataAPI(date : String) {
        let parameters : [String : Any]? = ["date" : date,"sortOnClient" : true]
        let service = Connect()
        service.fetchGet(endPoint: "matches",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                self!.parseData(data: data!)
                self!.tableView.reloadData()
                self!.loadingView.hideLoading()
            }
        }
    }
    
    func parseData(data : [String : Any]) {
        if let leaguesArr = data["leagues"] as? [[String : Any]] {
            for obj in leaguesArr {
                let leaguesObj = ResultMatchItem()
                leaguesObj.ccode = obj["ccode"] as? String
                leaguesObj.idMatch = obj["id"] as? Int
                leaguesObj.primaryId = obj["primaryId"] as? Int
                leaguesObj.name = obj["name"] as? String
                if let matchesArr = obj["matches"] as? [[String : Any]] {
                    var matchesData : [ResultMatchHomeTeamItem] = []
                    for matchesObjs in matchesArr {
                        let matchObj = ResultMatchHomeTeamItem()
                        matchObj.leagueId = matchesObjs["leagueId"] as? Int
                        matchObj.idHometeam = matchesObjs["id"] as? Int
                        matchObj.tournamentStage = matchesObjs["tournamentStage"] as? String
                        matchObj.timeTS = matchesObjs["timeTS"] as? Int
                        matchObj.statusId = matchesObjs["statusId"] as? Int
                        let homeInfo = InfoTeam()
                        if let matchesHome = matchesObjs["home"] as? [String : Any] {
                            homeInfo.id = matchesHome["id"] as? Int
                            homeInfo.name = matchesHome["name"] as? String
                            homeInfo.score = matchesHome["score"] as? Int
                            matchObj.home = homeInfo
                        }
                        let awayInfo = InfoTeam()
                        if let matchesHome = matchesObjs["away"] as? [String : Any] {
                            awayInfo.id = matchesHome["id"] as? Int
                            awayInfo.name = matchesHome["name"] as? String
                            awayInfo.score = matchesHome["score"] as? Int
                            matchObj.away = awayInfo
                        }
                        let statusMatches = StatusItemResultMatch()
                        if let statusMatchesObj = matchesObjs["status"] as? [String : Any] {
                            statusMatches.finished = statusMatchesObj["finished"] as? Bool
                            statusMatches.cancelled = statusMatchesObj["cancelled"] as? Bool
                            statusMatches.scoreStr = statusMatchesObj["scoreStr"] as? String
                            statusMatches.started = statusMatchesObj["started"] as? Bool
                            statusMatches.startDateStr = statusMatchesObj["startDateStr"] as? String
                            statusMatches.startTimeStr = statusMatchesObj["startTimeStr"] as? String
                            let reasonMatches = ResonMatchesItem()
                            if let reasonObj = statusMatchesObj["reason"] as? [String : String] {
                                reasonMatches.short = reasonObj["short"]
                                reasonMatches.long = reasonObj["long"]
                                statusMatches.reason = reasonMatches
                            }
                            matchObj.status = statusMatches
                        }
                        matchesData.append(matchObj)
                        leaguesObj.matches = matchesData
                        
                    }
                }
                self.dataMatch.append(leaguesObj)
            }
//            print("ehlloooo : ",self.dataMatch[0].matches![0].status?.scoreStr)
        }
    }
}
    
// tableView
extension ResultMatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataMatch[section].matches!.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataMatch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListResultMatchTableViewCell", for: indexPath) as! ListResultMatchTableViewCell
        let leaguesItem = dataMatch[indexPath.section]
        let matchesItem = leaguesItem.matches![indexPath.row]
        cell.homeTeam.text = matchesItem.home?.name
        cell.awayTeam.text = matchesItem.away?.name
        cell.iconHomeTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((matchesItem.home?.id!)!))"), completed: nil)
        cell.iconAwayTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((matchesItem.away?.id!)!))"), completed: nil)
        if (matchesItem.status?.started == false) {
            cell.result.text = matchesItem.status?.startTimeStr
        }else {
            cell.result.text = matchesItem.status?.scoreStr
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemGray6
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
        titleLabel.textColor = .black
        if let title = dataMatch[section].name as? String {
            titleLabel.text = title
        }
        view.addSubview(titleLabel)
        return view
    }
    
}
//get Date
extension ResultMatchViewController {
    func getDate(dateAsString : String) -> String {
        let start = dateAsString.index(dateAsString.startIndex, offsetBy: 5)
        let end = dateAsString.index(dateAsString.endIndex, offsetBy: -3)
        let range = start..<end
        let month = dateAsString[range]
        // year
        let startYear = dateAsString.index(dateAsString.startIndex, offsetBy: 0)
        let endYear = dateAsString.index(dateAsString.endIndex, offsetBy: -6)
        let rangeYear = startYear..<endYear
        let year = dateAsString[rangeYear]
        
        // day
        let startDay = dateAsString.index(dateAsString.startIndex, offsetBy: 8)
        let endDay = dateAsString.index(dateAsString.endIndex, offsetBy: 0)
        let rangeDay = startDay..<endDay
        let day = dateAsString[rangeDay]
        let selectedDate = year + month + day
        return String(selectedDate)
    }
}
