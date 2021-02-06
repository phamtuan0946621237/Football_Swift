//
//  TableResultMatchDetailViewController.swift
//  Football
//
//  Created by admin on 1/30/21.
//

import UIKit

class TableResultMatchDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableLeagueTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListTableLeagueTableViewCell")
        // Do any additional setup after loading the view.
    }

}
extension TableResultMatchDetailViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableLeagueTableViewCell", for: indexPath) as? ListTableLeagueTableViewCell
        return cell!
    }
}
