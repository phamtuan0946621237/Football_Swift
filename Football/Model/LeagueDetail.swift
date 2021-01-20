//
//  LeagueDetail.swift
//  Football
//
//  Created by admin on 1/15/21.
//

import Foundation

class LeagueDetailItem{
    var tableData : TableDataItem?
}
class TableDataItem{
    var tables : [ChartsTeamOfLeague]?
}

class ChartsTeamOfLeague {
    var ccode : String?
    var leagueId : Int?
    var pageUrl : String?
    var leagueName : String?
    var legend : [LegendChartOfLeague]?
    var table : [TableTeamLeagueItem]?
    var tables : [TablesTeamItem]?
}
class TablesTeamItem {
    var ccode : String?
    var leagueId : Int?
    var pageUrl : String?
    var leagueName : String?
    var legend : [LegendChartOfLeague]?
    var table : [TableTeamLeagueItem]?
}
class LegendChartOfLeague {
    var title : String?
    var color : String?
    var indices : [[String : Int]]?
    
}
class TableTeamLeagueItem {
    var qualColor : String?
    var idx : Int?
    var name : String?
    var idTeam : Int?
    var pageUrl : String?
    var played : Int?
    var wins : Int?
    var draws : Int?
    var losses : Int?
    var goalConDiff : Int?
    var scoresStr : String?
    var pts : Int?
}



