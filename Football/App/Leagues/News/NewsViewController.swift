//
//  NewsViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    var idLeague : Int?
    var seo : String?
    var dataNews : [NewsItem] = []
    let loadingView = ModalViewController()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getView() // view
        self.dataAPI(id: idLeague!, seo: seo!) // call Api
        loadingView.showLoading() // show loading
    }
}
// View
extension NewsViewController{
    func getView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsTableViewCell")
    }
}
// TableView
extension NewsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let item  = dataNews[indexPath.row]
        cell.content.text = item.title
        cell.sourceIcon.sd_setImage(with: URL(string: item.sourceIconUrl!), completed: nil)
        cell.imageContent.sd_setImage(with: URL(string: item.imageUrl!), completed: nil)
        cell.source.text = item.sourceStr
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = dataNews[indexPath.row].page?.url
        let slice = str![str!.startIndex..<str!.index(str!.startIndex, offsetBy: 3)]
        print("slice",slice)
        
        if(slice != "htt") {
            let vc = SFSafariViewController(url: URL(string: "https://www.fotmob.com" + ((dataNews[indexPath.row].page?.url)!))!)
            present(vc, animated: true)
        }else {
            let vc = SFSafariViewController(url: URL(string: (dataNews[indexPath.row].page?.url)!)!)
            present(vc, animated: true)
        }
        
        
    }
}

// call Api
extension NewsViewController {
    func dataAPI(id : Int,seo : String) {
        let parameters : [String : Any]? = ["id" : id,"tab" : "news","type" : "league","timeZone" : "Asia%2FSaigon","seo" : seo]
        let service = Connect()
        service.fetchGet(endPoint: "leagues",parram :parameters)
        service.completionHandler {
            [weak self] (data) in
            if(data != nil) {
                if let newsDataArr = data!["news"] as? [[String : Any]] {
                    for newDataObj in newsDataArr {
                        let newDataItem = NewsItem()
                        newDataItem.title = newDataObj["title"] as? String
                        newDataItem.imageUrl = newDataObj["imageUrl"] as? String
                        newDataItem.lead = newDataObj["lead"] as? String
                        newDataItem.sourceStr = newDataObj["sourceStr"] as? String
                        newDataItem.sourceIconUrl = newDataObj["sourceIconUrl"] as? String
                        if let pageNewsObj = newDataObj["page"] as? [String : Any] {
                            let pageNewItem = PageNewsItem()
                            pageNewItem.url = pageNewsObj["url"] as? String
                            newDataItem.page = pageNewItem
                        }
                        self!.dataNews.append(newDataItem)
                    }
                    print("heooooo : ",self!.dataNews[0].page?.url)
                }
                self!.loadingView.hideLoading()
                self!.tableView.reloadData()
            }
        }
    }
}
