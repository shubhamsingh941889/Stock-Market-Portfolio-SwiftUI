//
//  TradeScreenView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 03/05/22.
//

import SwiftUI

struct TradeScreen: View{
    
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var portfolioViewModel:PortfolioModel
    @ObservedObject var companyViewModel:CompanyProfileModel
    
    @State var qty: String = ""
    @State var showToast = false
    @State var showCongrats = false
    @State var txn_custom_msg = ""
    @State var success_msg = ""
    var ticker:String
    
 
    var body: some View{
        
//        ZStack(alignment: .topTrailing){
//            Color.white
            

        ZStack{
            if !showCongrats{
            VStack{
                
                
                HStack {
                
            Spacer()

        Button(action: {
            presentationMode.wrappedValue.dismiss()
//            portfolioViewModel.setBalance(value:24000)
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.black)
                .font(.headline)
                
                .padding(20)
            
        })
            }
                
               Text("Trade \(companyViewModel.ProfileArray[0].name) Shares")
                    .font(.headline)
                Spacer()
                Spacer()
                
                HStack{
                    Spacer()
                    TextField("0", text: $qty)
//                        .font(.largeTitle)
                        .font(.system(size: 96.0))
                        .keyboardType(.decimalPad)
                    
                    let quantity=Int(qty) ?? 0
                    
                    if (quantity>1){
                        Text("Shares")
                            .font(.largeTitle)
                    }
                    
                    else{
                        Text("Share")
                            .font(.largeTitle)
                    }
                    
                }
                HStack{
                    Spacer()
                    let Last_Price:Double=Double(companyViewModel.StockPriceArray[0].Last_Price) ?? 0
                     let curr_price:Double = Last_Price * (Double(qty) ?? 0 )
                    Text("x \(Last_Price,  specifier:"%.2f")/share = $\(curr_price,  specifier:"%.2f")")
                        
                }
                
                Spacer()
                
                HStack{
                    Text("$\(portfolioViewModel.getBalance(), specifier:"%.2f") available to buy \(ticker)")
                        .foregroundColor(Color.gray)
                }
                
                
                
                
                HStack{
                    Spacer()
                    Button(action:
                            {
//                        showToast = true
                        
                        let Last_Price:Double=Double(companyViewModel.StockPriceArray[0].Last_Price) ?? 0
                        let curr_price:Double = Last_Price * (Double(qty) ?? 0 )
                        let curr_balance = portfolioViewModel.getBalance()
                        
//                        let _ = print("showToast",showToast, showCongrats, curr_price, curr_balance)
                        
                        let curr_qty = (Int(qty) ?? 0)

                        if curr_qty==0{
                            showToast = true
                            txn_custom_msg = "Enter a valid amount"
                        }
                        else if curr_price>curr_balance{
                            showToast = true
                            txn_custom_msg = "Not enough to Buy"
                        }
                        
                        else{
                            showCongrats.toggle()
                            success_msg = "You have successfully bought \(qty) shares \nof \(ticker)"
                            portfolioViewModel.addPortfolio(ticker: ticker, quantity: curr_qty)
                            portfolioViewModel.setBalance(value: curr_price, type: "Buy")
                            portfolioViewModel.setNetWorth()
                        }
                        
                        
                    }, label:{
                        Text("Buy")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.horizontal, 65)
                            .padding([.top,.bottom] , 15)
                            .background(Color.green)
                            .cornerRadius(22)
                    }
                            
                           
                    )
                    
                    Spacer()
                    
                    Button(action:
                            {
//                        showToast = true
                        let sell_qty = (Int(qty) ?? 0)
                        let check_sell = portfolioViewModel.checkSell(ticker: ticker, quantity: sell_qty)
                        let Last_Price:Double=Double(companyViewModel.StockPriceArray[0].Last_Price) ?? 0
                        let curr_price:Double = Last_Price * (Double(qty) ?? 0 )
                        if sell_qty==0{
                            showToast = true
                            txn_custom_msg = "Enter a valid amount"
                        }
                        
                        else if !check_sell{
                            showToast = true
                            txn_custom_msg = "Not enough to Sell"
                        }
                        
                        else{
                            showCongrats.toggle()
                            success_msg = "You have successfully sold \(qty) shares \nof \(ticker)"
                            portfolioViewModel.SellStock(ticker: ticker, quantity: sell_qty)
                            portfolioViewModel.setBalance(value: curr_price, type: "Sell")
                            portfolioViewModel.setNetWorth()
                            
                            
                            
                        }
  
                        
                    }, label:{
                        Text("Sell")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.horizontal, 65)
                            .padding([.top,.bottom] , 15)
                            .background(Color.green)
                            .cornerRadius(22)
                    }
                            
                           
                    )
                    Spacer()
                }
                
                
//                Spacer()
            }.padding([.trailing, .leading], 12)
            
        }
            else{
                Color.green.ignoresSafeArea()
                VStack{
                    Spacer()
//                    HStack{
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
//                    }
                    Text(success_msg)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .padding(.top,10)
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Done")
                            .foregroundColor(.green)
                            .font(.headline)
                            .padding([.top, .bottom], 15)
                            .padding(.horizontal, 160)
                            .background(Color.white.cornerRadius(30))
                        
                    })
                        
                    
                    
//                    Spacer()
                }
            }
            
        }
        
        .overlay(Text("")
            .toast(message: txn_custom_msg,
               isShowing: $showToast,
               duration: Toast.short), alignment: .bottom)

        
            
  
//}
        
    }
}

//struct TradeScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        TradeScreenView()
//    }
//}
