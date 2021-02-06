//
//  Service.swift
//  PokemonCard
//
//  Created by admin on 12/21/20.
//

import Foundation
import Alamofire

class Connect {
    var url = "https://www.fotmob.com/"
    var urlSeason = "https://fotmobenetpulse.s3-external-3.amazonaws.com/"
    typealias ResCallback = (_ data : [String : Any]?) -> Void
    var callBack : ResCallback?
    
    func completionHandler(callBack : @escaping ResCallback) {
        self.callBack = callBack
    }
    func fetchPost() {
        AF.request("https://www.fotmob.com/contact_us",method: .post,parameters: nil , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    
    func fetchGet(endPoint : String,parram : [String: Any]?) {
        AF.request(self.url + endPoint,method: .get,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    
    func fetchGetLeague(endPoint : String,parram : [String: Any]?) {
        AF.request(urlSeason + endPoint,method: .get,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    func getAPIUrl(url : String) {
        AF.request(url,method: .get,parameters: nil , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    func fetchWorldNews(parram : [String : Any]?) {
        AF.request("https://apigw.fotmob.com/searchapi/search",method: .get,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    func fetchSearch(parram : [String : Any]?) {
        AF.request("https://apigw.fotmob.com/searchapi/suggest",method: .get,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
            if let jsonObj = response.value as? [String : Any] {
                self.callBack?(jsonObj as? [String : Any] )
            }
        }
    }
    
    
    
}
