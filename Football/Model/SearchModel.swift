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
