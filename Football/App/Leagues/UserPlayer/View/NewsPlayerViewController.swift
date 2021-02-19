//
//  NewsPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit
import SafariServices

class NewsPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var tableView: UITableView!
    var dataNewsPlayer : [NewsItem] = []
    
    // cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getView() // getView
    }
    
    func getView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsPlayerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsPlayerTableViewCell")
    }
}

// getData API
extension NewsPlayerViewController {
    func getData(data : [NewsItem]) {
        dataNewsPlayer = data
        tableView.reloadData()
    }
}


//tableView
extension NewsPlayerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataNewsPlayer.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = dataNewsPlayer[indexPath.row].page?.url
        let slice = str![str!.startIndex..<str!.index(str!.startIndex, offsetBy: 3)]
        print("slice",slice)
        
        if(slice != "htt") {
            let vc = SFSafariViewController(url: URL(string: "https://www.fotmob.com" + ((dataNewsPlayer[indexPath.row].page?.url)!))!)
            present(vc, animated: true)
        }else {
            let vc = SFSafariViewController(url: URL(string: (dataNewsPlayer[indexPath.row].page?.url)!)!)
            present(vc, animated: true)
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPlayerTableViewCell", for: indexPath) as? NewsPlayerTableViewCell
        let item = dataNewsPlayer[indexPath.row]
        cell!.content.text = item.title
        cell!.sourceStr.text = item.sourceStr
        cell!.sourceIcon.sd_setImage(with: URL(string: item.sourceIconUrl!), completed: nil)
        cell!.imageUrlNews.sd_setImage(with: URL(string: item.imageUrl!), completed: nil)
        return cell!
    }
}
