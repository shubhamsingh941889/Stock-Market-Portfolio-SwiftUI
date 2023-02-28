//
//  PeersModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import Foundation
struct SentimentKeys:Identifiable, Codable{
    var id:String = UUID().uuidString
    var reddit_metions:String
    var reddit_positive:String
    var reddit_negative:String
    var twitter_metions:String
    var twitter_positive:String
    var twitter_negative:String
    
}
