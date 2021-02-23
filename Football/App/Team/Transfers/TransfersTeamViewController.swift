//
//  TransfersTeamViewController.swift
//  Football
//
//  Created by admin on 2/19/21.
//

import UIKit

class TransfersTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataTransfer : [TransferItem] = []
    @IBOutlet weak var tableView: UITableView!
    var idTeam : Int?
    var nameClub : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTransferTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTransferTableViewCell")
        self.dataAPI(id: String(idTeam!), nameTeam: nameClub!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTransfer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTransferTableViewCell", for: indexPath) as! ListTransferTableViewCell
        let item = dataTransfer[indexPath.row]
        cell.fee.text = item.fee
        cell.fromClub.text = item.fromClub
        cell.date.text = item.fromDate! + " - " +  item.toDate!
        cell.name.text = item.name
        cell.toClub.text = item.toClub
        cell.marketValue.text =  (item.marketValue != nil) ? "Market value : " + item.marketValue! : "Market value : € 0M"
        cell.toClub.text = item.toClub
        cell.fromDate.text = item.transferDate
        cell.icon.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String(item.playerId!)).png"), completed: nil)
        cell.iconFromClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.fromClub!))"), completed: nil)
        cell.iconToClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.toClubId!))"), completed: nil)
        cell.fromClub.tintColor = UIColor.green
        cell.toClub.tintColor = UIColor.red
        switch item.typeTransfers {
        case "contract extension":
            cell.fee.isHidden = true
            cell.fromClub.tintColor = UIColor.black
            cell.toClub.tintColor = UIColor.black
            break;
        case "players in":
//            cell.iconFromClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.fromClub!))"), completed: nil)
//            cell.iconToClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.toClubId!))"), completed: nil)
            break;
        case "players out":
//            cell.iconFromClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.fromClub!))"), completed: nil)
//            cell.iconToClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.toClubId!))"), completed: nil)
            break;
        default:
            break
        }
        return cell
    }
    
    func convertModel(data : [String : Any]) {
        if let transfer = data["transfers"] as? [String : Any] {
            if let transfersData = transfer["data"] as? [String : Any] {
//                let transferItem = TransfersModel()
                var dataTransfers : [TransferItem] = []
                
                if let transfersContractArr = transfersData["contract extension"] as? [[String : Any]] {
                    for transfersContractObj in transfersContractArr {
                        let transferChild = TransferItem()
                        transferChild.fee = transfersContractObj["fee"] as? String
                        transferChild.fromClub = transfersContractObj["fromClub"] as? String
                        transferChild.fromClubId = transfersContractObj["fromClubId"] as? Int
                        transferChild.fromDate = transfersContractObj["fromDate"] as? String
                        transferChild.marketValue = transfersContractObj["marketValue"] as? String
                        transferChild.name = transfersContractObj["name"] as? String
                        transferChild.playerId = transfersContractObj["playerId"] as? Int
                        transferChild.position = transfersContractObj["position"] as? String
                        transferChild.toClub = transfersContractObj["toClub"] as? String
                        transferChild.toClubId = transfersContractObj["toClubId"] as? Int
                        transferChild.toDate = transfersContractObj["toDate"] as? String
                        transferChild.transferDate = transfersContractObj["transferDate"] as? String
                        transferChild.typeTransfers = "contract extension"
                        dataTransfers.append(transferChild)
                    }
                }
                if let transfersPlayerInArr = transfersData["players in"] as? [[String : Any]] {
                    for transfersPlayerInObj in transfersPlayerInArr {
                        let transferChild = TransferItem()
                        transferChild.fee = transfersPlayerInObj["fee"] as? String
                        transferChild.fromClub = transfersPlayerInObj["fromClub"] as? String
                        transferChild.fromClubId = transfersPlayerInObj["fromClubId"] as? Int
                        transferChild.fromDate = transfersPlayerInObj["fromDate"] as? String
                        transferChild.marketValue = transfersPlayerInObj["marketValue"] as? String
                        transferChild.name = transfersPlayerInObj["name"] as? String
                        transferChild.playerId = transfersPlayerInObj["playerId"] as? Int
                        transferChild.position = transfersPlayerInObj["position"] as? String
                        transferChild.toClub = transfersPlayerInObj["toClub"] as? String
                        transferChild.toClubId = transfersPlayerInObj["toClubId"] as? Int
                        transferChild.toDate = transfersPlayerInObj["toDate"] as? String
                        transferChild.transferDate = transfersPlayerInObj["transferDate"] as? String
                        transferChild.typeTransfers = "players in"
                        dataTransfers.append(transferChild)
                    }
                }
                if let transfersPlayerOutArr = transfersData["players out"] as? [[String : Any]] {
                    for transfersPlayerOutObj in transfersPlayerOutArr {
                        let transferChild = TransferItem()
                        transferChild.fee = transfersPlayerOutObj["fee"] as? String
                        transferChild.fromClub = transfersPlayerOutObj["fromClub"] as? String
                        transferChild.fromClubId = transfersPlayerOutObj["fromClubId"] as? Int
                        transferChild.fromDate = transfersPlayerOutObj["fromDate"] as? String
                        transferChild.marketValue = transfersPlayerOutObj["marketValue"] as? String
                        transferChild.name = transfersPlayerOutObj["name"] as? String
                        transferChild.playerId = transfersPlayerOutObj["playerId"] as? Int
                        transferChild.position = transfersPlayerOutObj["position"] as? String
                        transferChild.toClub = transfersPlayerOutObj["toClub"] as? String
                        transferChild.toClubId = transfersPlayerOutObj["toClubId"] as? Int
                        transferChild.toDate = transfersPlayerOutObj["toDate"] as? String
                        transferChild.transferDate = transfersPlayerOutObj["transferDate"] as? String
                        transferChild.typeTransfers = "players out"
                        dataTransfers.append(transferChild)
                    }
                }
                self.dataTransfer = dataTransfers
                print("self.dataTransfer",self.dataTransfer)
            }
        }
    }
    
    func dataAPI(id : String,nameTeam : String) {
//        let service = Connect()
//        service.getAPIUrl(url: "https://www.fotmob.com/teams?id=8634&tab=transfers&type=team&timeZone=Asia%2FSaigon&seo=barcelona")
        let parameters : [String : Any]? = ["id" : id,"tab" : "transfers","type" : "team","timeZone" : "Asia%2FSaigon","seo" : nameTeam]
        let service = Connect()
        service.fetchGet(endPoint: "teams",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                DispatchQueue.global().async { [weak self] in
                    self!.convertModel(data : data!)
                    DispatchQueue.main.async {
                        self!.tableView.reloadData()
                    }
                }
                
                
            }
        }
    }
}
