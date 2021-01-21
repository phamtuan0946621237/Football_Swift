//
//  TransfersViewController.swift
//  Football
//
//  Created by admin on 1/21/21.
//

import UIKit

class TransfersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    var idLeague : Int?
    var seo : String?
    @IBOutlet weak var tableView: UITableView!
    var dataTransfer : [TransferItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hellooo",idLeague,seo)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTransferTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTransferTableViewCell")
        self.dataAPI(id: idLeague!, seo: seo!)
    }
}


extension TransfersViewController {
    func dataAPI(id : Int,seo : String) {
        let parameters : [String : Any]? = ["id" : id,"tab" : "transfers","type" : "league","timeZone" : "Asia%2FSaigon","seo" : seo]
        let service = Connect()
        service.fetchGet(endPoint: "leagues",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                print("phamtuan ",data)
                if let transfers = data!["transfers"] as? [String : Any] {
                    if let dataTransfersArr = transfers["data"] as? [[String : Any]] {
                        for dataTransfersObj in dataTransfersArr {
                            let dataTransfersItem = TransferItem()
                            dataTransfersItem.name = dataTransfersObj["name"] as? String
                            dataTransfersItem.fee = dataTransfersObj["fee"] as? String
                            dataTransfersItem.fromClub = dataTransfersObj["fromClub"] as? String
                            dataTransfersItem.fromClubId = dataTransfersObj["fromClubId"] as? Int
                            dataTransfersItem.fromDate = dataTransfersObj["fromDate"] as? String
                            dataTransfersItem.marketValue = dataTransfersObj["marketValue"] as? String
                            dataTransfersItem.playerId = dataTransfersObj["playerId"] as? Int
                            dataTransfersItem.position = dataTransfersObj["position"] as? String
                            dataTransfersItem.toClub = dataTransfersObj["toClub"] as? String
                            dataTransfersItem.toClubId = dataTransfersObj["toClubId"] as? Int
                            dataTransfersItem.toDate = dataTransfersObj["toDate"] as? String
                            dataTransfersItem.transferDate = dataTransfersObj["transferDate"] as? String
                            self!.dataTransfer.append(dataTransfersItem)
                        }
                    }
                }
                self!.tableView.reloadData()
                print(self?.dataTransfer[0].name)
            }
        }
    }
}
extension TransfersViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("dataTransfer.count",dataTransfer.count)
        return dataTransfer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTransferTableViewCell", for: indexPath) as? ListTransferTableViewCell
        let item = dataTransfer[indexPath.row]
        cell?.fee.text = item.fee
        cell?.fromClub.text = item.fromClub
        cell?.date.text = item.fromDate! + " - " +  item.toDate!
        cell?.name.text = item.name
        cell?.toClub.text = item.toClub
        cell?.marketValue.text =  (item.marketValue != nil) ? "Market value : " + item.marketValue! : "Market value : € 0M"
        cell?.toClub.text = item.toClub
        cell?.fromDate.text = item.transferDate
        cell?.iconFromClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.fromClubId!))"), completed: nil)
        cell?.iconToClub.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String(item.toClubId!))"), completed: nil)
        cell?.icon.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String(item.playerId!)).png"), completed: nil)
        return cell!
    }
}
