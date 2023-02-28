//
//  FooterView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 14/04/22.
//

import SwiftUI

struct FooterView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        HStack {
            Spacer()
            Button(
                action: {
                            openURL(URL(string: "https://finnhub.io/")!)
                    
                },
                label:{Text("Powered by Finnhub.io")
                    .foregroundColor(Color.gray)} )
            Spacer()
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
