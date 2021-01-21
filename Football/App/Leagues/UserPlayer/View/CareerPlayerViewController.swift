//
//  CareerPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class CareerPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    let infoPlayer = InfoPlayerViewController()
    @IBOutlet weak var tableView: UITableView!
    var dataObj : InfoPlayerItemObj? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CareerItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CareerItemTableViewCell")
        print("jjjjjjjj",infoPlayer.dataInfoPlayer?.name)
    }
    func getData(data : InfoPlayerItemObj) {
//        print("teamName",data.origin?.teamName)
        print("career_ tot;e",data.relatedNews![0].title)
//        fetchDataUserPlayer(id : id)
//        let concurrentQueue = DispatchQueue(label: "swiftlee.concurrent.queue", attributes: .concurrent)
//        concurrentQueue.async {
            self.dataObj = data
//            DispatchQueue.main.async { [self] in
//                namePlayer.text = self.dataObj?.name
//            }
//        }
    }
}

extension CareerPlayerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerItemTableViewCell", for: indexPath) as? CareerItemTableViewCell
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemGray6
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
        titleLabel.textColor = .black
        titleLabel.text = "hello"
            view.addSubview(titleLabel)
            return view
    }
    
}
