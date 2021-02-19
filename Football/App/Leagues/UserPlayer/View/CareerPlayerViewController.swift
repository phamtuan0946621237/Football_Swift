//
//  CareerPlayerViewController.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import UIKit

class CareerPlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    // variable
    @IBOutlet weak var titleCareer: UILabel!
//    let infoPlayer = InfoPlayerViewController()
    @IBOutlet weak var tableView: UITableView!
    var dataObj : InfoPlayerItemObj? = nil
    var dataCareerArr : Array<[CareerPlayerDetailInfo]> = []
    
    // cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getView()
    }
    
    // getView
    func getView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CareerItemTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "CareerItemTableViewCell")
        tableView.showsVerticalScrollIndicator = false
    }
}

// get data API
extension CareerPlayerViewController {
    func getData(data : CareerInfoPlayer) {
        dataCareerArr.append(data.nationalteam!)
        dataCareerArr.append(data.senior!)
        
        tableView.reloadData()
    }
}

// tableView
extension CareerPlayerViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCareerArr[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareerItemTableViewCell", for: indexPath) as? CareerItemTableViewCell
        let sectionArr = dataCareerArr[indexPath.section]
        let item = sectionArr[indexPath.row]
        cell!.numberGoal.text = item.goals != nil ? item.goals : "0"
        cell!.numberMatch.text = item.appearances != nil ? item.appearances : "0"
        cell!.date.text = item.startDate! + " - " + item.endDate!
        cell!.team.text = item.team
        cell?.teamIcon.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((item.teamId)!))"), completed: nil)
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataCareerArr.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        view.backgroundColor = .systemGray6
        let titleLabel = UILabel(frame: CGRect(x: 16, y: 5, width: tableView.frame.size.width - 32, height: 20))
        titleLabel.textColor = .black
        if section == 0 {
            titleLabel.text = "NATIONAL TEAM"
        }else {
            titleLabel.text = "SENIOR"
        }
            view.addSubview(titleLabel)
            return view
    }
    
}
