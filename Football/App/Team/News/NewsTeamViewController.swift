//
//  NewsTeamViewController.swift
//  Football
//
//  Created by admin on 2/18/21.
//

import UIKit

class NewsTeamViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var newsData : [NewsItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsTableViewCell")
        print("newsData",newsData)
        // Do any additional setup after loading the view.
    }
    
}

extension NewsTeamViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        let item = newsData[indexPath.row]
        cell.content.text = item.title
        cell.sourceIcon.sd_setImage(with: URL(string: item.sourceIconUrl!), completed: nil)
        cell.imageContent.sd_setImage(with: URL(string: item.imageUrl!), completed: nil)
        cell.source.text = item.sourceStr
        return cell
    }
}
