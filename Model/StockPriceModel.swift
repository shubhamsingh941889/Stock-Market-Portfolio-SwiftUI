//
//  StockPriceModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 21/04/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct StockPriceKeys:Identifiable, Codable, Hashable{
    var id:String = UUID().uuidString
    var ticker:String
    var name:String
    var Last_Price:String
    var Change:String
    var Change_Percentage:String
    var High_Price:String
    var Low_Price:String
    var Open_Price:String
    var Prev_Close:String
    var Timestamp:String

}






