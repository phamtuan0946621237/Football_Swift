//
//  InfoPlayerItem.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import Foundation

class InfoPlayerItemObj {
    var name : String?
    var origin : OriginInfoPlayer?
    var idPlayer : Int?
    var playerProps : [InfoPlayerDataItem]?
    var careerItems : CareerInfoPlayer?
    var relatedNews : [NewsItem]?
}
class OriginInfoPlayer {
    var teamName : String?
    var teamId : Int?
    var positionDesc : PositionDescInfoPlayer?
}
class PositionDescInfoPlayer {
    var nonPrimaryPositions : String?
    var primaryPosition : String?
}
class InfoPlayerDataItem {
    var value : String?
    var title : String?
}
class CareerInfoPlayer {
    var senior : [CareerPlayerDetailInfo]?
    var nationalteam : [CareerPlayerDetailInfo]?
}

class CareerPlayerDetailInfo {
    var appearances : String?
    var endDate : String?
    var goals : String?
    var hasUncertainData : Bool?
    var participantId : Int?
    var startDate : String?
    var team : String?
    var teamId : Int?
}


