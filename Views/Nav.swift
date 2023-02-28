//
//  Nav.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 29/04/22.
//

import SwiftUI

struct Nav: View {
    var body: some View {
        NavigationView{
        NavigationLink(destination: Text("Second View")) {
            Text("hello")
        }
        }
    }
}

struct Nav_Previews: PreviewProvider {
    static var previews: some View {
        Nav()
    }
}
