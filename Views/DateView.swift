//
//  DateView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 14/04/22.
//

import SwiftUI

struct DateView: View {
    var body: some View {
        Section(){
            Text(Date.now,
                 format: .dateTime.day().month().year())
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.gray)
            
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView()
    }
}
