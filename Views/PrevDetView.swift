////
////  DetailsView.swift
////  StocksAppCS571
////
////  Created by Shubham Singh on 14/04/22.
////
//
//import SwiftUI
//import Combine
//import Alamofire
//import SwiftyJSON
//import Kingfisher
//import WebKit
//
//
//
//struct DetailsView: View {
//    
//    @State var isFavorite = false
//    @State var flag = false
//    @State var custom_msg = ""
//    
//    @State var showToast = false
//    var ticker:String
//    @State var showSheet:Bool = false
//    @State var showNewsSheet:Bool = false
//    
//
//
//
//    @EnvironmentObject var favoritesViewModel:FavoritesModel
//    @EnvironmentObject var portfolioViewModel:PortfolioModel
//    
//
//    
//    @StateObject var companyViewModel:CompanyProfileModel = CompanyProfileModel()
//
//    var body: some View {
//        
//
//        ZStack{
//        
//        if companyViewModel.isLoading{
//
//            ProgressView("Fetching Data")
//                
//
//        }
//            
//            else{
//                
//                if (companyViewModel.ProfileArray.count>0 && companyViewModel.StockPriceArray.count>0 && companyViewModel.PeersArray.count>0 && companyViewModel.SentimentsArray.count>0 && companyViewModel.NewsArray.count>0 )
//                {
//                
//         ZStack {
//               
//             ScrollView(.vertical){
//                 
//                 CompanyProfileView(companyViewModel: companyViewModel)
//
//                 TabView{
//                     let change:Double=Double(companyViewModel.StockPriceArray[0].Change) ?? 0
//                     let timestamp:Int = Int( companyViewModel.StockPriceArray[0].Timestamp) ?? 0
////                     let _ = print("timestamp",timestamp)
//                        
//                        
//                     WebView(htmlfilename: "daily", ticker: ticker, change:change, timestamp: timestamp)
//                            .frame(height: 430, alignment: .bottom)
//                            .tabItem {
//                                Image(systemName: "chart.line.uptrend.xyaxis")
//                                Text("Hourly")
//                            }
//
//                        WebView(htmlfilename: "historical", ticker: ticker)
//                            .frame(height: 430, alignment: .bottom)
//                            .tabItem {
//                                Image(systemName: "clock.fill")
//                                Text("Historical")
//                            }
//
//                    }
//                    .frame(height: 470.0)
//                    .onAppear() {
//                          UITabBar.appearance().barTintColor = .white
//                                               }
//
//                    VStack {
//                        HStack{
//                            Text("Portfolio")
//                                .font(.title)
//                                .fontWeight(.medium)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//                        HStack{
//                            
//                            
//                            
//                            if portfolioViewModel.checkStockExists(ticker: ticker)
//                            {
//                                let stockData = portfolioViewModel.getStockData(ticker: ticker)
//                                let qty = Int(stockData?.Quantity ?? 0)
//                                let avg_cost = round((stockData?.Avg_Cost ?? 0)*100)/100.0
//                                let total_cost = round((stockData?.Total_Cost ?? 0)*100)/100.0
//                                let mkt_value = round((stockData?.Market_Value ?? 0)*100)/100.0
//                                let change = round((stockData?.User_Holdings_Change ?? 0)*100)/100.0
//                                
//                                VStack(alignment:.leading){
//                                    
//                                        Text("Shares Owned: ")
//                                        .fontWeight(.bold)
//                                        +
//                                        Text("\(qty)")
//                                    
//                                 
//                                        Text("Avg. Cost/Share: ")
//                                        .fontWeight(.bold)
//                                        +
//                                        Text("$\(avg_cost, specifier: "%.2f")")
//                                    
// 
//                                        Text("Total Cost: ")
//                                        .fontWeight(.bold)
//                                        +
//                                        Text("$\(total_cost, specifier: "%.2f")")
//                                    
//                                    
//                                        if change==0{
//                                            Text("Change: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(change, specifier: "%.2f")")
//                                                .foregroundColor(Color.gray)
//                                            
//                                            Text("Market Value: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(mkt_value, specifier: "%.2f")")
//                                                .foregroundColor(Color.gray)
//                                               
//                                        }
//                                        else if change>0{
//                                            Text("Change: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(change, specifier: "%.2f")")
//                                                .foregroundColor(Color.green)
//                                            
//                                            Text("Market Value: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(mkt_value, specifier: "%.2f")")
//                                                .foregroundColor(Color.green)
//                                        }
//                                        else{
//                                            Text("Change: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(change, specifier: "%.2f")")
//                                                .foregroundColor(Color.red)
//                                            
//                                            Text("Market Value: ")
//                                                .fontWeight(.bold)
//                                            +
//                                            Text("$\(mkt_value, specifier: "%.2f")")
//                                                .foregroundColor(Color.red)
//                                        }
//                                    
//                                    
//                                    
//                                }
//                            }
//                            
//                            else{
//                                VStack(alignment: .leading)
//                                {
//                                Text("You have 0 shares of \(ticker).")
//
//                                Text("Start Trading!")
//                                }
//                            }
//                            
//
//                            Spacer()
//
//                            Button(action:
//                                    {
//                                showSheet.toggle()
//
//                            }
//
//                                   , label:{
//                                Text("Trade")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                    .padding(.horizontal, 45)
//                                    .padding([.top,.bottom] , 15)
//                                    .background(Color.green)
//                                    .cornerRadius(22)
//                            }
//
//
//
//                            )
//                            .sheet(isPresented: $showSheet, content: {
//                                TradeScreen(companyViewModel:companyViewModel, ticker:ticker)
//
//                            }
//                            )
//
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//
//
//
//
//                    }
//
//                    .padding([.trailing,.leading], 12)
//
//
//
//                 StatsView(companyViewModel:companyViewModel)
//                 
//                 AboutView(companyViewModel: companyViewModel)
//
//                 InsightsView(companyViewModel: companyViewModel)
//
//
//                 WebView(htmlfilename: "insights", ticker: ticker)
//                     .frame(height: 430, alignment: .bottom)
//                 WebView(htmlfilename: "eps", ticker: ticker)
//                     .frame(height: 430, alignment: .bottom)
//
//                 NewsView(companyViewModel: companyViewModel, showNewsSheet: $showNewsSheet)
//
//           
//    }
//             
//            .navigationTitle(ticker)
//            
//                          .toolbar {
//                            ToolbarItem(placement: .navigationBarTrailing) {
//
//
//                              Button(action:
//                                        {
//
//                                  showToast = true
//
//                                  if (
//                                      favoritesViewModel.favoritesArray.contains(
//                                          where :{
//                                              $0.ticker==ticker
//                                          }
//                                      )
//                                  )
//
//                                  {
//                                      self.isFavorite = true
//
//                                      favoritesViewModel.deleteFavorites(ticker: ticker)
//                                      self.flag = true
//                                      self.custom_msg="Removing \(ticker) from Favorites"
//
//                                  }
//                                  else{
//                                      self.isFavorite = false
////                                      print("add")
//                                      favoritesViewModel.addFavorites(ticker: ticker)
//                                          self.custom_msg="Adding \(ticker) to Favorites"
//                                  }
//
//                              })
//                                {
//
//                                if (
//                                    favoritesViewModel.favoritesArray.contains(
//                                        where :{
//                                            $0.ticker==ticker
//                                        }
//                                    )
//                                )
//                                  {
//
//
//                                      Image(systemName: "plus.circle.fill")
//
//
//                                  }
//                                  else{
////                                      let _ = print("flag", self.flag)
//                                      if self.flag{
//
//                                          
//                                              Image(systemName: "plus.circle")
//                                          
//                                      }
//                                      else{
//                                      Image(systemName: "plus.circle")
//                                      }
//
//
//
//                                  }
//                              }
//                            }
//                          }
//   }
//         .overlay(Text("")
//             .toast(message: custom_msg,
//                isShowing: $showToast,
//                duration: Toast.short), alignment: .bottom)
//                }
//                
//            }
//            
//        }
//        .onAppear{
//            companyViewModel.getAllData(ticker: ticker)
//        }
//                  
//  
//}
//
//
//    struct DetailsView_Previews: PreviewProvider {
//        static var previews: some View {
//            DetailsView(ticker: "AAPL")
//        }
//    }
//
//}
//
//
//
//
