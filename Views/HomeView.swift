//
//  HomeView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 14/04/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON



struct HomeView: View {

    @State private var tickerText:String = ""
    @State private var data2: [String] = []
    
    @StateObject var searchViewModel:SearchModel = SearchModel()
    @StateObject var favoritesViewModel:FavoritesModel = FavoritesModel()
    @StateObject var portfolioViewModel:PortfolioModel = PortfolioModel()
    
    let timer = Timer.publish(every: 15.0, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
//        let _ = Self._printChanges()
        
       
        
        NavigationView {
                
                    List {
                        
                        if tickerText.isEmpty {
                            
                    DateView()
                    PortfolioView()
                    let _ = print("home")
                    FavoritesView()
                    FooterView()
                        }
                        
                        else{
//                            let _ = print("sr", tickerText)
                            SearchView(searchViewModel:searchViewModel)
                                .onChange(of: tickerText.uppercased(), perform: { newValue in
                    //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
                                    searchViewModel.updateArray()
                                    searchViewModel.updateAutoComplete(newValue:newValue)
                    //                }
                                })
                        }
                        
                        
                    }
//                    .onAppear{
////                    print("on Appaer")
//                        let _ = print("home",favoritesViewModel.favoritesArray)
//
//                    }
                    .listStyle(.insetGrouped)
                        
                       .navigationTitle("Stocks")
                        .toolbar {
                            EditButton()
                        }

            
        }
        .searchable(text: $tickerText)
        .environmentObject(favoritesViewModel)
        .environmentObject(portfolioViewModel)
        .onReceive(timer, perform: { _ in
            
            favoritesViewModel.getLatestFavorites()
            portfolioViewModel.getSavedCash()
            portfolioViewModel.getLatestPortfolio()
//            portfolioViewModel.getSavedNetWorth()
            
//            let _ = print("In loop",portfolioViewModel.Balance)
            
        })


        }
}
    
