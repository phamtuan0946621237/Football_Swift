//
//  SearchViewController.swift
//  Football
//
//  Created by admin on 1/28/21.
//

import UIKit


class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var tableView: UITableView!
    var dataSearch : SearchModel?
    var keyDataSearch = ["squadMemberSuggest","matchSuggest","leagueSuggest","teamSuggest"]
    @IBOutlet weak var searchButtonView: UIButton!
    @IBOutlet weak var searchInput: UITextField!
    var dataArr : Array<[SearchModelItem]> = []
    //cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButtonView.layer.cornerRadius = 8
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SearchMatchesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "SearchMatchesTableViewCell")
    }
    // action
    @IBAction func onClickSearch(_ sender: Any) {
        if let textInputSearch = searchInput.text {
        self.getDataSearch(term: textInputSearch)// call API
            self.dataArr = []
        }
    }
}

extension SearchViewController {
    func getDataSearch(term : String) {
        let parameters : [String : Any]? = ["term" : term,"lang" : "en,vi"]
        let service = Connect()
        service.fetchSearch(parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                let dataSearchObj = SearchModel()
                for i in 0..<self!.keyDataSearch.count {
                    print("self!.keyDataSearch",self!.keyDataSearch[i])
                self!.parseData(dataSearchObj: dataSearchObj, key: self!.keyDataSearch[i], data: data!) } // parse Data
                self!.dataSearch = dataSearchObj
                if let teamSuggestData = self!.dataSearch?.teamSuggest {
                    self!.dataArr.append(teamSuggestData)
                }
                
                if let matchSuggestData = self!.dataSearch?.matchSuggest {
                    self!.dataArr.append(matchSuggestData)
                }
                if let leagueSuggestData = self!.dataSearch?.leagueSuggest {
                    self!.dataArr.append(leagueSuggestData)
                }
                
                if let squadMemberSuggestData = self!.dataSearch?.squadMemberSuggest {
                    self!.dataArr.append(squadMemberSuggestData)
                }
                
                self!.tableView.reloadData()
            }
        }
    }
    
    // parse Data
    func parseData(dataSearchObj : SearchModel,key : String,data : [String : Any]) {
        if let dataArr = data[key] as? Array<[String : Any]> {
            var dataSearch : [SearchModelItem] = []
            for obj in dataArr {
                let item = SearchModelItem()
                    item.length = obj["length"] as? Int
                    item.textSearch = obj["text"] as? String
                    item.key = key
                    item.offset = obj["offset"] as? Int
                if let optionsArr = obj["options"] as? Array<[String : Any]> {
                    var optionsData : [OptionSearchModelItem] = []
                    for optionsObj in optionsArr {
                        let optionsItem = OptionSearchModelItem()
                        optionsItem.name = optionsObj["text"] as? String
                        optionsItem.score = optionsObj["score"] as? Int
                        if let payloadObj = optionsObj["payload"] as? [String : Any] {
                            let payloadItem = PayloadOptionSearchModelItem()
                            payloadItem.matchDate = payloadObj["matchDate"] as? String
                            payloadItem.idPayload = payloadObj["id"] as? String
                            if payloadObj["countryCode"]  != nil {
                                payloadItem.countryCode = payloadObj["countryCode"] as? String
                            }
                            if payloadObj["homeTeamId"]  != nil {
                                payloadItem.homeTeamId = payloadObj["homeTeamId"] as? String
                            }
                            if payloadObj["awayTeamId"]  != nil {
                                payloadItem.awayTeamId = payloadObj["awayTeamId"] as? String
                            }
                            if payloadObj["homeName"]  != nil {
                                payloadItem.homeName = payloadObj["homeName"] as? String
                            }
                            if payloadObj["awayName"]  != nil {
                                payloadItem.awayName = payloadObj["awayName"] as? String
                            }
                            optionsItem.payload = payloadItem
                        }
                        optionsData.append(optionsItem)
                    }
                    item.options = optionsData
                }
                
                dataSearch.append(item)
            }
            switch key {
                case "squadMemberSuggest":
                    dataSearchObj.squadMemberSuggest = dataSearch
                break;
                case "leagueSuggest":
                    dataSearchObj.leagueSuggest = dataSearch
                break;
                case "matchSuggest":
                    dataSearchObj.matchSuggest = dataSearch
                break;
                case "teamSuggest":
                    dataSearchObj.teamSuggest = dataSearch
                break;
                default :
                break;
            }
            
        }
    }
}

//table View
extension SearchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArr.count > 0{
            if let option = dataArr[section][0].options{
                return option.count
            }
            
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMatchesTableViewCell", for: indexPath) as? SearchMatchesTableViewCell
        if let sectionTable = dataArr[indexPath.section] as? [SearchModelItem] {
            if let option = sectionTable[0].options {
                let item = option[indexPath.row]
                let startNameIndex = item.name!.index(item.name!.startIndex, offsetBy: 0)
                let endNameIndex = item.name!.index(item.name!.endIndex, offsetBy: -(item.payload?.idPayload!.count)! - 1)
                let lengthName = startNameIndex..<endNameIndex
                let resultName = item.name![lengthName]
                    switch sectionTable[0].key {
                    case "squadMemberSuggest":
                        cell?.homeIcon.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String((item.payload?.idPayload)!)).png"), completed: nil)
                        cell?.result.text = String(resultName)
                        break
                    case "leagueSuggest":
                        cell?.homeIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/league/" + (item.payload?.idPayload)! ), completed: nil)
                        cell?.result.text = String(resultName)
                        break
                    case "matchSuggest":
                        cell?.result.textAlignment = .center
                        cell?.homeIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((item.payload?.homeTeamId!)!))"), completed: nil)
                        cell?.awayIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((item.payload?.awayTeamId!)!))"), completed: nil)
                        cell?.result.text = item.name
                        break
                    case "teamSuggest":
                        cell?.homeIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((item.payload?.idPayload!)!))"), completed: nil)
                        cell?.result.text = String(resultName)
                        break
                    default:
                        break;
                    }
                            }
            }
            
        return cell!
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        if dataArr.count > 0 {
            view.backgroundColor = .systemGray6
            let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
            titleLabel.textColor = .black
            if let sectionTable = dataArr[section] as? [SearchModelItem] {
                switch sectionTable[0].key {
                case "squadMemberSuggest":
                    titleLabel.text = "Players and Managers"
                    break
                case "leagueSuggest":
                    titleLabel.text = "Leagues"
                    break
                case "matchSuggest":
                    titleLabel.text = "Matches"
                    break
                case "teamSuggest":
                    titleLabel.text = "Teams"
                    break
                default:
                    break;
                }
                
                view.addSubview(titleLabel)
            }
        }
        
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let sectionTable = dataArr[indexPath.section] as? [SearchModelItem] {
            if let option = sectionTable[0].options {
                let item = option[indexPath.row]
                switch sectionTable[0].key {
                case "matchSuggest" :
                    let vc = storyboard?.instantiateViewController(withIdentifier: "ResultMatchDetailViewController") as?
                        ResultMatchDetailViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                    vc?.idMatch = Int((item.payload?.idPayload)!)
                    break;
                case "squadMemberSuggest":
                    let vc = storyboard?.instantiateViewController(withIdentifier: "UserPlayerViewController") as?
                        UserPlayerViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                    vc?.idPlayer = Int((item.payload?.idPayload)!)
                    break;
                case "teamSuggest":
                    
                    break;
                default :
                    break;
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataArr.count > 0 {
            return dataArr.count
        }
        return 0
    }
}

