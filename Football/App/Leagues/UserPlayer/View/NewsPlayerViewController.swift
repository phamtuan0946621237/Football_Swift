//
//  NewsPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class NewsPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var tableView: UITableView!
    var dataObj : InfoPlayerItemObj? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsPlayerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsPlayerTableViewCell")
//        getData(data : nil )
    }
    func getData(data : InfoPlayerItemObj) {
//        print("teamName",data.origin?.teamName)
        print("title_news",data.relatedNews![0].title)
//        fetchDataUserPlayer(id : id)
//        let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
//        concurrentQueue.async {
            self.dataObj = data
//        if dataObj != nil {
//            tableView.reloadData()
//        }
        
//            DispatchQueue.main.async { [self] in
//                namePlayer.text = self.dataObj?.name
//            }
//        }
    }

}
extension NewsPlayerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataObj != nil {
            return (self.dataObj!.relatedNews!.count)
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPlayerTableViewCell", for: indexPath) as? NewsPlayerTableViewCell
        return cell!
    }
}
