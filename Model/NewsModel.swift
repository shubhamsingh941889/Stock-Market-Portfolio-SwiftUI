//
//  NewsModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import Foundation

struct NewsKeys:Identifiable, Codable{
    var id:String = UUID().uuidString
    var datetime:String
    var headline:String
    var image:String
    var source:String
    var summary:String
    var news_url:String
    var source_datetime:String
    
}
