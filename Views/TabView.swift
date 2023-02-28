//
//  TabView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 29/04/22.
//

import SwiftUI

struct myTabView: View {
    var body: some View {
        
        
        WebView(htmlfilename: "daily", ticker: "AAPL", change:-0.3, timestamp: 1651262404)
               
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        myTabView()
    }
}
