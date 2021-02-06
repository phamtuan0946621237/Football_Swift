//
//  LiveTickerViewController.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class LiveTickerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
//    let data = ["hello","hi","goood","hello","hi","goood"]
    @IBOutlet weak var tableView: UITableView!
    var data : [EventLiveTickerData] = []
    var heightText : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "handleHeightTextLiveTickerCard", bundle: Bundle.main), forCellReuseIdentifier: "handleHeightTextLiveTickerCard")
        tableView.register(UINib(nibName: "ListLIveTickerNormalTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListLIveTickerNormalTableViewCell")
    }
    func getDataTable(data : LiveTickerData) {
        if let eventData = data.Events {
            self.data = eventData
        }
        tableView.reloadData()
    }   
}

extension LiveTickerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListLIveTickerNormalTableViewCell", for: indexPath) as! ListLIveTickerNormalTableViewCell
        let item = self.data[indexPath.row]
        
        cell.getTitle(textTitle : item.Description!)
        cell.setHeight(handle: { [self](height : CGFloat) in
            self.heightText = height
        })
        
        var elapsedPlus : String?
        if item.Elapsed! > 0 {
            elapsedPlus = "+" + String(item.ElapsedPlus!)
            cell.time.text = String(item.Elapsed!) +  (item.ElapsedPlus! > 0 ? elapsedPlus as! String : "")
        }else if item.Elapsed! < 0 {
            cell.time.text = String(item.Elapsed!)
        }else {
            cell.time.text = "*"
        }
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let height =  self.heightText {
            return height + 40
        }
        return 140
    }
}
