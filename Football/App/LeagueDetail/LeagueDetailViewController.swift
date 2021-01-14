//
//  LeagueDetailViewController.swift
//  Football
//
//  Created by admin on 1/12/21.
//

import UIKit

class LeagueDetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    var seo : String?
    var idLeague : Int?
    var name : String?
    
    var dataFeature = ["TABLE","MATCHES","STARS","NEWS","OVER VIEW"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(self.seo)
//        print(self.idLeague)
//        print(self.name)
        
    }

}
extension LeagueDetailViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFeature.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureLeagueCollectionViewCell", for: indexPath) as! FeatureLeagueCollectionViewCell
        cell.titleFeature.text = dataFeature[indexPath.row]
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
