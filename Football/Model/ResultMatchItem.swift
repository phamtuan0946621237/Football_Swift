//
//  ResultMatchItem.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import Foundation
class ResultMatch {
    var leagues : [ResultMatchItem]?
    var date : String?
//    var userSettings : String?
}
class ResultMatchItem {
    var ccode : String?
    var idMatch : Int?
    var primaryId : Int?
    var name : String?
    var matches : [[String : Any]]?
//        [ResultMatchHomeTeamItem]?
}
class ResultMatchHomeTeamItem {
    var idHometeam : Int?
    var leagueId : Int?
    var home : [String : Any]?
    var away : [String : Any]?
    var tournamentStage : String?
    var status : [String : Any]?
    var timeTS : Int?
    var statusId : Int?
}
class InfoTeam {
    var id : Int?
    var score : Int?
    var name : String?
    
}
class StatusItemResultMatch {
    var finished : Bool?
    var started : Bool?
    var cancelled : Bool?
    var scoreStr : String?
    var startDateStr : String?
    var reason : [String : String]?
}

class resonType {
    var short : String?
    var long : String?
}
