//
//  WorldNewsViewController.swift
//  Football
//
//  Created by admin on 1/22/21.
//

import UIKit
import SafariServices
class WorldNewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var dataWorldNews : WorldNewsItem?
    @IBOutlet weak var tableView: UITableView!
    var loadingView = ModalViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WorldNewsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "WorldNewsTableViewCell")
        tableView.showsVerticalScrollIndicator = false
        // Do any additional setup after loading the view.
        dataAPI()
        loadingView.showLoading()
    }
    
//    WorldNewsTableViewCell

}

extension WorldNewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataWorldNews != nil && dataWorldNews?.hits != nil {
            self.loadingView.hideLoading()
            return (dataWorldNews?.hits?.count)!
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorldNewsTableViewCell", for: indexPath) as? WorldNewsTableViewCell
        if dataWorldNews != nil {
            let item = dataWorldNews?.hits![indexPath.row].source
            cell!.nameSource.text = (item?.source)! + " - " + (item?.dateUpdated)!
            cell!.content.text = item?.title
            cell!.imageUrl.sd_setImage(with: URL(string: (item?.imageUrl)!), completed: nil)
        }
        
            
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataWorldNews?.hits![indexPath.row].source
        let vc = SFSafariViewController(url: URL(string: (item?.shareUri)!)!)
            present(vc, animated: true)
        
        
    }
}

extension WorldNewsViewController {
    func dataAPI() {
        let parameters : [String : Any]? = ["term" : "newstype_world","lang" : "en","startIndex" : 0]
        let service = Connect()
        service.fetchWorldNews(parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                print("kkkkkkkkk : ",data as Any)
                let dataObj = WorldNewsItem()
                if let hitsData = data!["hits"] as? [String : Any] {
                    var hitsDataChildArr : [HitsWorldNewsItem] = []
                    if let hitsDataChild = hitsData["hits"] as? [[String : Any]] {
                        for hitsDataChildObj in hitsDataChild {
                            let hitsDataChildItem = HitsWorldNewsItem()
                            if let sourcehitDataChildObj = hitsDataChildObj["_source"] as? [String : Any] {
                                let sourceWorldNewsObj = SourceWorldNews()
                                sourceWorldNewsObj.idSource = sourcehitDataChildObj["id"] as? Int
                                sourceWorldNewsObj.dateUpdated = sourcehitDataChildObj["dateUpdated"] as? String
                                sourceWorldNewsObj.imageUrl = sourcehitDataChildObj["imageUrl"] as? String
                                sourceWorldNewsObj.shareUri = sourcehitDataChildObj["shareUri"] as? String
                                sourceWorldNewsObj.source = sourcehitDataChildObj["source"] as? String
                                sourceWorldNewsObj.title = sourcehitDataChildObj["title"] as? String
                                hitsDataChildItem.source = sourceWorldNewsObj
                            }
                            hitsDataChildArr.append(hitsDataChildItem)
                        }
                    }
                    dataObj.hits = hitsDataChildArr
                }
                self!.dataWorldNews = dataObj
                print("gggggg : ",self!.dataWorldNews?.hits![0].source?.title)
                
                self!.tableView.reloadData()
            }
        }
    }
}
