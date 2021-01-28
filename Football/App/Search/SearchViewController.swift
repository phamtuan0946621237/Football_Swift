//
//  SearchViewController.swift
//  Football
//
//  Created by admin on 1/28/21.
//

import UIKit

class SearchViewController: UIViewController {
    var dataSearch : SearchModel?
    var keyDataSearch = ["squadMemberSuggest","matchSuggest","leagueSuggest","teamSuggest"]
    @IBOutlet weak var searchButtonView: UIButton!
    @IBOutlet weak var searchInput: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("searchInput",searchInput)
        searchButtonView.layer.cornerRadius = 8
    }
    

    
    @IBAction func onClickSearch(_ sender: Any) {
        if let textInputSearch = searchInput.text {
        self.getDataSearch(term: textInputSearch)// call API
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
                print("hello",data)
                let dataSearchObj = SearchModel()
                for i in 0..<self!.keyDataSearch.count {
                    print("self!.keyDataSearch",self!.keyDataSearch[i])
                self!.parseData(dataSearchObj: dataSearchObj, key: self!.keyDataSearch[i], data: data!) // parse Data
                }
                self!.dataSearch = dataSearchObj
                print("self!.dataSearch",self!.dataSearch?.matchSuggest![0].options![0].payload!.homeName)
            }
        }
    }
    
    // parse Data
    func parseData(dataSearchObj : SearchModel,key : String,data : [String : Any]) {
        if let squadMemberSuggestArr = data[key] as? Array<[String : Any]> {
            var squadMemberSuggestData : [SearchModelItem] = []
            for squadMemberSuggestObj in squadMemberSuggestArr {
                let squadMemberSuggestItem = SearchModelItem()
                squadMemberSuggestItem.length = squadMemberSuggestObj["length"] as? Int
                squadMemberSuggestItem.textSearch = squadMemberSuggestObj["text"] as? String
                squadMemberSuggestItem.offset = squadMemberSuggestObj["offset"] as? Int
                if let optionsArr = squadMemberSuggestObj["options"] as? Array<[String : Any]> {
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
                    squadMemberSuggestItem.options = optionsData
                }
                
                squadMemberSuggestData.append(squadMemberSuggestItem)
            }
            switch key {
                case "squadMemberSuggest":
                    dataSearchObj.squadMemberSuggest = squadMemberSuggestData
                break;
                case "leagueSuggest":
                    dataSearchObj.leagueSuggest = squadMemberSuggestData
                break;
                case "matchSuggest":
                    dataSearchObj.matchSuggest = squadMemberSuggestData
                break;
                case "teamSuggest":
                    dataSearchObj.teamSuggest = squadMemberSuggestData
                break;
                default :
                break;
            }
            
        }
    }
}
