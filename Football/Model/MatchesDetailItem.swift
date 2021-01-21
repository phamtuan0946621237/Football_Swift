//
//  MatchesDetailItem.swift
//  Football
//
//  Created by admin on 1/21/21.
//

import Foundation

class MatchesDetailItem {
    var nav : [String]?
    var header : HeaderMatchesDetail?
}
class HeaderMatchesDetail {
    var status : StatusHeaderMatchesDetail?
    var teams : [TeamsHeaderMatchesDetail]?
}
class StatusHeaderMatchesDetail {
    var cancelled : Bool?
    var finished : Bool?
    var scoreStr : String?
    var startDateStr : String?
    var started : Bool?
    var whoLostOnAggregated : String?
    var startTimeStr : String?
}
class TeamsHeaderMatchesDetail {
    var imageUrl : String?
    var name : String?
    var pageUrl : String?
    var score : Int?
}

