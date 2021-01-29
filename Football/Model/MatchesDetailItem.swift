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
    var content : ContentmatchesDetailItem?
}

class ContentmatchesDetailItem {
    var h2h : HeadToHeadContentMatchesDetailItem?
    var lineup : LineupContentMatchesDetailItem?
    var matchFacts : MatchFactsContentMatchesDetailItem?
    var stats : StatsContentMatchesDetailItem?
    var table : TableContentMatchesDetailItem?
    var liveticker : LivetickerContentMatchesDetailItem?
    
}

class LivetickerContentMatchesDetailItem {
    var showSuperLive : Bool?
    var url : String?
    var teams : [String]?
}

// -------------------------------
// table
class TableContentMatchesDetailItem {
    var teams : [Int]?
    var url : String?
}

// -------------------------------
// Stats
class StatsContentMatchesDetailItem {
    var stats : [StatsOfStatsContentMatchesDetailItem]?
    var teamColors : TeamColorsStatsContentMatchesDetailItem?
}
class StatsOfStatsContentMatchesDetailItem {
    var title : String?
    var stats : [StastArrContentMatchesDetailItem]?
}

class StastArrContentMatchesDetailItem {
    var highlighted : String?
    var stats : [Int]?
    var title : String?
    var type : String?
}
class TeamColorsStatsContentMatchesDetailItem {
    var away : String?
    var home : String?
}

// -------------------------------
// Lineup
class LineupContentMatchesDetailItem {
    
}

// -------------------------------
// HeadToHead
class HeadToHeadContentMatchesDetailItem {
    var matches : [MatchesHeadToHeadContentMatchesDetailItem]?
    var summary : [Int]?
    var finished : Bool?
    var matchUrl : String?
    var league : LeagueHeadToHeadContentMatchesDetailItem?
    var home : InfoHeadToHeadContentMatchesDetailItem?
    var away : InfoHeadToHeadContentMatchesDetailItem?
}
class InfoHeadToHeadContentMatchesDetailItem {
    var idTeam : String?
    var name : String?
}
class LeagueHeadToHeadContentMatchesDetailItem {
    var name : String?
    var pageUrl : String?
}


class MatchesHeadToHeadContentMatchesDetailItem {
    var time : String?
    var status : StatusItemResultMatch?
}

// -------------------------------
// Match Facts
class MatchFactsContentMatchesDetailItem {
    var events : EventsMatchFactsContentMatchesDetailItem?
    var highlights : HighLightsMatchFactsContentMatchesDetailItem?
    var infoBox : InfoBoxMatchFactsContentMatchesDetailItem?
    var matchId : Int?
    var odds : OddsMatchFactsContentMatchesDetailItem?
    var playerOfTheMatch : PlayerOfTheMatchMatchFactsContentMatchesDetailItem?
}

class PlayerOfTheMatchMatchFactsContentMatchesDetailItem {
    var idPlayerOfTheMatch : Int?
    var name : NamePlayerOfTheMatchMatchFactsContentMatchesDetailItem?
    var pageUrl : String?
    var rating : RatingPlayerOfTheMatchMatchFactsContentMatchesDetailItem?
    var role : String?
    var teamId : Int?
    var teamName : String?
    
}
class RatingPlayerOfTheMatchMatchFactsContentMatchesDetailItem {
    var num : Double?
}
class NamePlayerOfTheMatchMatchFactsContentMatchesDetailItem {
    var firstName : String?
    var lastName : String?
}
class OddsMatchFactsContentMatchesDetailItem {
    var show : Bool?
}
class InfoBoxMatchFactsContentMatchesDetailItem {
    var matchDate : String?
    var Referee : RefereeMatchFactsContentMatchesDetailItem?
    var Stadium : StadiumMatchFactsContentMatchesDetailItem?
    var Tournament : TournamentMatchFactsContentMatchesDetailItem?
}
class RefereeMatchFactsContentMatchesDetailItem {
    var imgUrl : String?
    var textReferee : String?
}
class TournamentMatchFactsContentMatchesDetailItem {
    var idTournament : Int?
    var link : String?
    var textTournament : String?
}

class StadiumMatchFactsContentMatchesDetailItem {
    var lat : String?
    var long : String?
    var name : String?
}
class EventsMatchFactsContentMatchesDetailItem {
    var ongoing : Bool?
    var events : [EventsOfEventsMatchFactsContentMatchesDetailItem]?
}
class EventsOfEventsMatchFactsContentMatchesDetailItem {
    var card : String?
    var isHome : Bool?
    var nameStr : String?
    var overloadTimeStr : Bool?
    var profileUrl : String?
    var reactKey : String?
    var time : Int?
    var timeStr : String?
    var type : String?
}

class HighLightsMatchFactsContentMatchesDetailItem {
    var image : String?
    var source : String?
    var url : String?
}



// ----------------------------
//
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

