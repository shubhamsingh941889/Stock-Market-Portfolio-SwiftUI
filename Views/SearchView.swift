//
//  SearchView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 19/04/22.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject  var searchViewModel:SearchModel
//    @ObservedObject var webViewData = WebViewData()
    @State private var selectedCoin: String? = nil
    @State private var showDetailedView: Bool = false
    var body: some View{
//        let _ = Self._printChanges()

//        if searchViewModel.isLoading{
//            ProgressView("Fetching Data")
//
//        }
//        else{
            
 
//        ZStack {
//            let _ = print("searchViewModel.autoCompleteArray",searchViewModel.autoCompleteArray)
//            List{
                    ForEach(searchViewModel.autoCompleteArray) { data in
                        NavigationLink(
//                            isActive: $showDetailedView,
                            destination: {DetailsView(ticker:data.symbol)})
                        {
                        
                        VStack(alignment: .leading){
                            Text(data.symbol)
                            
                                .font(.title)
                                .fontWeight(.bold)
                                
                            Text(data.description)
//                                .onTapGesture {
////                                    print("yy")
//                                    segue(coin:data.symbol)
////                                    webViewData.functionCaller.send()
//
//                                }
                        }
                        }
                    }
//                    .background(
//
//
//                        NavigationLink(
//                            isActive: $showDetailedView,
//                            destination: {DetailLoadingView(ticker:$selectedCoin)},
//                           label: {EmptyView()})
//
//                )
//            }
            
//        }
//    let _ = print("sheeow",showDetailedView)
        
        

    }
    private func segue(coin:String){
        selectedCoin = coin
        showDetailedView.toggle()
//        print("show",showDetailedView)
    }
    
}


//    .background(
//        NavigationLink(
//            isActive: $showDetailedView,
//           destination: DetailsView(ticker:$selectedCoin),
//           label: {EmptyView()})
//    )
