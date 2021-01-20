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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsPlayerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "NewsPlayerTableViewCell")
    }

}
extension NewsPlayerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsPlayerTableViewCell", for: indexPath) as? NewsPlayerTableViewCell
        return cell!
    }
}
