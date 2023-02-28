//
//  PeersModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import Foundation
struct PeersKey:Identifiable, Codable{
    var id:String = UUID().uuidString
    var peers:[String]
}
