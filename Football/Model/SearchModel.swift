//
//  SearchModel.swift
//  Football
//
//  Created by admin on 1/28/21.
//

import Foundation

class SearchModel {
    var squadMemberSuggest : [SearchModelItem]?
    var leagueSuggest : [SearchModelItem]?
    var matchSuggest : [SearchModelItem]?
    var teamSuggest : [SearchModelItem]?
}

class SearchModelItem {
    var textSearch : String?
    var offset : Int?
    var length : Int?
    var key : String?
    var options : [OptionSearchModelItem]?
}
class OptionSearchModelItem {
    var name : String?
    var score : Int?
    var payload : PayloadOptionSearchModelItem?
}
class PayloadOptionSearchModelItem {
    var matchDate : String?
    var idPayload : String?
    var homeTeamId : String?
    var awayTeamId : String?
    var homeName : String?
    var awayName : String?
    var countryCode : String?
}


class TeamModelItemData {
    var tabs : [String]?
    var details : DetailTeamModelItemData?
}
class DetailTeamModelItemData {
    var idTeam : Int?
    var type : String?
    var name : String?
    var country : String?
}

class FixTuresDataModel {
    var away : AwayFixturesModel?
    var home : HomeFixturesModel?
    var idMatch : Int?
    var notStarted : Bool?
    var pageUrl : String?
    var status : StatusItemResultMatch?
}
class AwayFixturesModel {
    var idAway : Int?
    var name : String?
    var score : Int?
}

class HomeFixturesModel {
    var idHome : Int?
    var name : String?
    var score : Int?
}
