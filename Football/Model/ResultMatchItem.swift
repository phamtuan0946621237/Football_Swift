//
//  ResultMatchItem.swift
//  Football
//
//  Created by admin on 1/11/21.
//

import Foundation
class ResultMatch {
    var leagues : [ResultMatchItem]?
}
class ResultMatchItem {
    var ccode : String?
    var idMatch : Int?
    var primaryId : Int?
    var name : String?
    var matches : [ResultMatchHomeTeamItem]?
}
class ResultMatchHomeTeamItem {
    var idHometeam : Int?
    var leagueId : Int?
    var home : InfoTeam?
    var away : InfoTeam?
    var tournamentStage : String?
    var status : StatusItemResultMatch?
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
    var reason : ResonMatchesItem?
    var startTimeStr : String?
}

class ResonMatchesItem {
    var short : String?
    var long : String?
}
