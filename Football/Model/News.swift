//
//  News.swift
//  Football
//
//  Created by admin on 1/20/21.
//

import Foundation

class NewsItem {
    var imageUrl : String?
    var title : String?
    var sourceStr : String?
    var lead : String?
    var sourceIconUrl : String?
    var page : PageNewsItem?
}
class PageNewsItem {
    var url : String?
}
