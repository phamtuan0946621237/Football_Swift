//
//  StatsMatchDetailViewController.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class StatsMatchDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListStatsMatchDetailTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListStatsMatchDetailTableViewCell")
        // Do any additional setup after loading the view.
    }

}
extension StatsMatchDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListStatsMatchDetailTableViewCell", for: indexPath) as? ListStatsMatchDetailTableViewCell
        
        return cell!
    }
    
}
