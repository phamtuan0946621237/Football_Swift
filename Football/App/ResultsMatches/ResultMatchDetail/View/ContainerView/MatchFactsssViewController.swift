//
//  MatchFactsssViewController.swift
//  Football
//
//  Created by admin on 2/4/21.
//

import UIKit
import SafariServices

class MatchFactsssViewController: UIViewController {
    @IBOutlet weak var stadium: UILabel!
    @IBOutlet weak var youtubeView: YoutubeMatchFactsUIView!
    @IBOutlet weak var star: UILabel!
    @IBOutlet weak var iconTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!
    @IBOutlet weak var namePlayer: UILabel!
    @IBOutlet weak var tourbanebt: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var iconPlayer: UIImageView!
    
    @IBOutlet weak var viewPlayerStar: UIView!
    var dataMatchFacts : MatchFactsContentMatchesDetailItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("helloooooo")
        let vc = SFSafariViewController(url: URL(string: (dataMatchFacts?.highlights?.url)!)!)
        present(vc, animated: true)
        // Do what you want
    }
    
    func getApi(data : MatchFactsContentMatchesDetailItem) {
        dataMatchFacts = data
//        print("dataMatchFacts",dataMatchFacts!.events?.events![0].nameStr)
        if dataMatchFacts?.playerOfTheMatch == nil {
            youtubeView.isHidden = true
            viewPlayerStar.isHidden = true
        }else {
            if let name = dataMatchFacts!.playerOfTheMatch?.name {
                self.namePlayer.text = name.firstName! + " " + name.lastName!
            }
            self.iconPlayer.sd_setImage(with: URL(string: "https://images.fotmob.com/image_resources/playerimages/\(String((dataMatchFacts!.playerOfTheMatch?.idPlayerOfTheMatch!)!)).png"), completed: nil)
            if let idTeam =  dataMatchFacts!.playerOfTheMatch?.teamId{
                self.iconTeam.sd_setImage(with: URL(string: "https://www.fotmob.com/images/team/\(String((idTeam)))"), completed: nil)
            }
            self.nameTeam.text = dataMatchFacts?.playerOfTheMatch?.teamName
            self.star.text = (dataMatchFacts!.playerOfTheMatch?.rating?.num)! + "*"
            self.youtubeView.urlLink.text = dataMatchFacts?.highlights?.source
            if let imageYoutube = dataMatchFacts?.highlights?.image {
                self.youtubeView.icon.sd_setImage(with: URL(string: imageYoutube), completed: nil)
            }else {
                youtubeView.isHidden = true
            }
            
        }
           

        
        self.matchDate.text = dataMatchFacts?.infoBox?.matchDate
        self.stadium.text = dataMatchFacts?.infoBox?.Stadium?.name
        self.tourbanebt.text = dataMatchFacts?.infoBox?.Tournament?.textTournament
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.youtubeView.addGestureRecognizer(gesture)
    }
    
}
extension MatchFactsssViewController {
    
}
