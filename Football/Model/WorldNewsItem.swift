//
//  WorldNewsItem.swift
//  Football
//
//  Created by admin on 1/22/21.
//

import Foundation

class WorldNewsItem {
    var hits : [HitsWorldNewsItem]?
}
class HitsWorldNewsItem {
    var source : SourceWorldNews?
}
class SourceWorldNews {
    var idSource : Int?
    var dateUpdated : String?
    var imageUrl : String?
    var shareUri : String?
    var source : String?
    var title : String?
}
