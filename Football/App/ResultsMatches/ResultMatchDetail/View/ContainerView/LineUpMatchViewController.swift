//
//  LineUpMatchViewController.swift
//  Football
//
//  Created by admin on 2/5/21.
//

import UIKit

class LineUpMatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LineupTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "LineupTableViewCell")
        // Do any additional setup after loading the view.
    }
}
extension LineUpMatchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LineupTableViewCell", for: indexPath) as! LineupTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
