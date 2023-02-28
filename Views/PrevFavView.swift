////
////  FavoritesView.swift
////  StocksAppCS571
////
////  Created by Shubham Singh on 14/04/22.
////
//
//import SwiftUI
//
//struct FavoritesView: View {
//    
//    
//    @EnvironmentObject var favoritesViewModel:FavoritesModel
//    
////    @State var temp:[String]
////    @Environment(\.isSearching) var isSearching
////    @ObservedObject var companyViewModel:CompanyProfileModel
////    init(){
////        for item in favoritesViewModel.favoritesArray {
//////            item in
////            print("heyy",item)
//////            favoritesViewModel.getStockPrice(ticker: item)
////
////
////        }
//////        self.companyViewModel = CompanyProfileModel(ticker: "AAPL")
////    }
////
//    var body: some View {
//        
////        let _ = Self._printChanges()
//        
////        let _ = print("fav",favoritesViewModel.favoritesArray)
//        
//       
//        
//        Section(header: Text("Favorites")){
//            
////            let _ = print("dd",favoritesViewModel.favoritesArray)
//
//                
////                ForEach(favoritesViewModel.StockPriceArray){
////                    temp in
////                    NavigationLink{}
////                    Text(temp.Last_Price)
////                }
//
//
//
//                
////            let _ = print("fav ar",favoritesViewModel.favoritesArray)
//            
//            ForEach(favoritesViewModel.favoritesArray){
//                item in
////                let _ = print(favoritesViewModel.StockPriceArray[0].ticker)
//                NavigationLink(destination: DetailsView(ticker:item.ticker))
//        {
//            VStack {
//                    HStack {
//                     VStack(alignment: .leading) {
//                         Text(item.ticker)
//                                .font(.title3)
//                                .fontWeight(.bold)
//                         Text(item.name)
//                                .font(.subheadline)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.gray)
//                        }
//                        Spacer()
//                        VStack(alignment: .trailing) {
//                            let Last_Price:Double=Double(item.Last_Price) ?? 0
//                            Text("$\(Last_Price, specifier:"%.2f")")
//                                .font(.title3)
//                                .fontWeight(.bold)
//                            HStack{
//                                let change:Double=Double(item.Change) ?? 0
//                                let change_percent:Double = Double(item.Change_Percentage) ?? 0
//                                
//                                if  change>0{
//                                    Image(systemName: "arrow.up.right")
//                                        .foregroundColor(Color.green)
//                                    Text("$\(change,specifier: "%.2f") (\(change_percent,specifier: "%.2f")%)").foregroundColor(Color.green)
//                                }
//                                else if change<0{
//                                    Image(systemName: "arrow.down.forward")
//                                        .foregroundColor(Color.red)
//                                    Text("$\(change,specifier: "%.2f") (\(change_percent,specifier: "%.2f")%)").foregroundColor(Color.red)
//                                }
//                                else{
//                                    Text("$\(change,specifier: "%.2f") (\(change_percent,specifier: "%.2f")%)").foregroundColor(Color.red)
//                                }
//                            }
//                        }
//                    }
//                    }
//            }
//            
//            }.onDelete (perform:favoritesViewModel.deleteItem )
//                .onMove (perform:favoritesViewModel.moveItem )
//  
//        }
//        
//    }
//    }
//    
//
////struct FavoritesView_Previews: PreviewProvider {
////    static var previews: some View {
////        FavoritesView()
////    }
////}
