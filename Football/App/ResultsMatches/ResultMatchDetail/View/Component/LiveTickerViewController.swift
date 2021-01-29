//
//  LiveTickerViewController.swift
//  Football
//
//  Created by admin on 1/29/21.
//

import UIKit

class LiveTickerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListLiveTickerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ListLiveTickerTableViewCell")
        // Do any additional setup after loading the view.
    }
    
}

extension LiveTickerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListLiveTickerTableViewCell", for: indexPath) as? ListLiveTickerTableViewCell
        cell!.titleListLiveTicker.text = "hello "
        cell!.valueListLiveTicker.text = "hi "
        return cell!
    }
}
