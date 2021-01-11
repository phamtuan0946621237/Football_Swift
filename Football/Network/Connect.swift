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
    typealias ResCallback = (_ data : [String : Any]?) -> Void
    var callBack : ResCallback?
    
    func completionHandler(callBack : @escaping ResCallback) {
        self.callBack = callBack
    }
    func fetchPost(endPoint : String,parram : [String: Any]?) {
        AF.request(self.url + endPoint,method: .post,parameters: parram , encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON { (response) in
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
}
