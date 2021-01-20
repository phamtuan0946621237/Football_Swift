//
//  ListStatsFilterViewController.swift
//  Football
//
//  Created by admin on 1/19/21.
//

import UIKit
import Alamofire
class ListStatsFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    var typeStats : String?
    var SeasonStatsLeagueArr : [SeasonStatLinksItem] = []
    var TopStatsArr : [TopStatsItem] = []
    var listStatsData : [ListStatsItemLeague] = []
    var idLeague : Int?
    var pathURL : String?
    var pickerView = UIPickerView()
    var pickerTypeView = UIPickerView()
    @IBOutlet weak var seasonPicker: UITextField!
    @IBOutlet weak var typeStatsPicker: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let loadingView = ModalViewController()
    var selectedIndexLoadMore : Int = 0
    
    // life
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLeagueAPI(idLeague: idLeague!) // call Api
        getMainView() // get mainView
        loadingView.showLoading()
    }
}

extension ListStatsFilterViewController {
    // mainView
    func getMainView() {
        getViewPicker() // get picker
        getViewTableView() // get Tableview
        self.hideKeyboardWhenTappedAround() // dismis keyboard
    }
    func getViewTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "ListStatsFilterTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListStatsFilterTableViewCell")
    }
    func getViewPicker() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerTypeView.delegate = self
        pickerTypeView.dataSource = self
        seasonPicker.inputView = pickerView
        typeStatsPicker.inputView = pickerTypeView
        seasonPicker.textAlignment = .center
        typeStatsPicker.textAlignment = .center
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
    
    // convert URL
    func convertStringUrl(url : String) -> String {
        let index = url.index(url.endIndex, offsetBy: 5 - url.count)
        let mySubstring = url[index...] // playground
        let urlList = "https:" + mySubstring
        return urlList
    }
}

// UiPicker
extension ListStatsFilterViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.pickerView {
            return SeasonStatsLeagueArr[row].Name
        } else if pickerView == self.pickerTypeView {
            return self.TopStatsArr[row].Title
        } else {
            return nil
        }
     }
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.SeasonStatsLeagueArr.count
        return self.TopStatsArr.count
      }
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == self.pickerView {
                seasonPicker.text = self.SeasonStatsLeagueArr[row].Name
                self.TopStatsArr = []
                self.dataTopStatsAPI(endPoint: self.SeasonStatsLeagueArr[row].RelativePath!)
                self.listStatsData = []
                self.selectedIndexLoadMore = 0
            } else if pickerView == self.pickerTypeView {
                typeStatsPicker.text = self.TopStatsArr[row].Title
                self.pathURL = self.TopStatsArr[row].StatLocation
                self.fetchListStatsLeague(url: self.convertStringUrl(url: self.pathURL!))
                self.listStatsData = []
                self.selectedIndexLoadMore = 0
            }
       }
}

// tableview
extension ListStatsFilterViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listStatsData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserPlayerViewController") as?
            UserPlayerViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.idPlayer = listStatsData[indexPath.row].ParticiantId
//        vc?.seo = dataLeague[indexPath.row].seo
//        vc?.idLeague = dataLeague[indexPath.row].idLeague
//        vc?.name = dataLeague[indexPath.row].name
//        vc?.icon = dataLeague[indexPath.row].icon
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListStatsFilterTableViewCell", for: indexPath) as? ListStatsFilterTableViewCell
        if(listStatsData.count > 0) {
            let item = listStatsData[indexPath.row]
            cell?.stt.text = String(indexPath.row + 1)
            cell!.number.text = String(item.StatValue!)
            cell?.name.text = item.ParticipantName
            cell?.icon.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String((item.ParticiantId)!)).png"), completed: nil)
        }
        return cell!
    }
    
}

// loadmore
extension ListStatsFilterViewController {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        selectedIndexLoadMore += 1
        self.listStatsData = []
        self.fetchListStatsLeague(url: self.convertStringUrl(url: self.pathURL!))
    }
}

// fetch API
extension ListStatsFilterViewController {
    func dataLeagueAPI(idLeague : Int) {
        let service = Connect()
        service.fetchGetLeague(endPoint : "webcl/leagues/league\(idLeague).json.gz",parram: nil)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                if let SeasonStatsArr = data!["SeasonStatLinks"] as? [[String : Any]] {
                    for SeasonStatsObj in SeasonStatsArr {
                        let SeasonStatsItem = SeasonStatLinksItem()
                        SeasonStatsItem.Name = SeasonStatsObj["Name"] as? String
                        SeasonStatsItem.CountryCode = SeasonStatsObj["CountryCode"] as? String
                        SeasonStatsItem.RelativePath = SeasonStatsObj["RelativePath"] as? String
                        SeasonStatsItem.League = SeasonStatsObj["League"] as? String
                        SeasonStatsItem.StageId = SeasonStatsObj["StageId"] as? Int
                        SeasonStatsItem.TemplateId = SeasonStatsObj["TemplateId"] as? Int
                        SeasonStatsItem.TournamentId = SeasonStatsObj["TournamentId"] as? Int
                        
                        self!.SeasonStatsLeagueArr.append(SeasonStatsItem)
                        self!.seasonPicker.text = self!.SeasonStatsLeagueArr[0].Name
                    }
                }
                self!.dataTopStatsAPI(endPoint: self!.SeasonStatsLeagueArr[0].RelativePath!)
            }
        }
    }
    
    func dataTopStatsAPI(endPoint : String) {
        let service = Connect()
        service.fetchGetLeague(endPoint: endPoint, parram: nil)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                if let SeasonStatsArr = data!["TopLists"] as? [[String : Any]] {
                    for SeasonStatsObj in SeasonStatsArr {
                        let SeasonStatsItem = TopStatsItem()
                        SeasonStatsItem.LocalizedSubtitleId = SeasonStatsObj["LocalizedSubtitleId"] as? String
                        SeasonStatsItem.LocalizedTitleId = SeasonStatsObj["LocalizedTitleId"] as? String
                        SeasonStatsItem.Order = SeasonStatsObj["Order"] as? Int
                        SeasonStatsItem.StatFormat = SeasonStatsObj["StatFormat"] as? String
                        SeasonStatsItem.StatLocation = SeasonStatsObj["StatLocation"] as? String
                        SeasonStatsItem.StatName = SeasonStatsObj["StatName"] as? String
                        SeasonStatsItem.SubstatFormat = SeasonStatsObj["SubstatFormat"] as? String
                        SeasonStatsItem.Subtitle = SeasonStatsObj["Subtitle"] as? String
                        SeasonStatsItem.Title = SeasonStatsObj["Title"] as? String
                        self!.TopStatsArr.append(SeasonStatsItem)
                    }
                }
                self!.typeStatsPicker.text = self?.TopStatsArr[0].Title
                self!.pathURL = self?.TopStatsArr[0].StatLocation
                self!.fetchListStatsLeague(url: self!.convertStringUrl(url: self!.pathURL!))
            }
        }
    }
    
    func fetchListStatsLeague(url : String) {
        let service = Connect()
        service.getListStatsLeague(url : url)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                self!.loadingView.hideLoading()
                let arr = data!["TopLists"] as? [[String : Any]]
                if let arrdata = arr![0]["StatList"] as? [[String : Any]] {
                    for obj in arrdata {
                        let item = ListStatsItemLeague()
                        item.ParticipantName = obj["ParticipantName"] as? String
                        item.ParticiantId = obj["ParticiantId"] as? Int
                        item.Rank = obj["Rank"] as? Int
                        item.TeamId = obj["TeamId"] as? Int
                        item.TeamName = obj["TeamName"] as? String
                        item.StatValue = obj["StatValue"] as? Int
                            if(self!.listStatsData.count < (self!.selectedIndexLoadMore + 1) * 10) {
                                self!.listStatsData.append(item)
                            }
                    }
                }
                self!.tableView.reloadData()
            }
        }
    }
}


