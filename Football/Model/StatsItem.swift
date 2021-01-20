//
//  StatsItem.swift
//  Football
//
//  Created by admin on 1/18/21.
//

import Foundation

class StatsItem {
    var stats : StatsItemsType?
}

class StatsItemsType {
    var player : [StatsLeagueItem]?
    var team : [StatsLeagueItem]?
}
class StatsLeagueItem {
    var header : String?
    var topThree : [TopThreeStatsItem]?
}
class TopThreeStatsItem {
    var name : String?
    var showTeamFlag : Bool?
    var teamId : Int?
    var idPlayer : Int?
    var teamName : String?
    var value : Int?
}
