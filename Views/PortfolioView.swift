//
//  PortfolioView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 14/04/22.
//

import SwiftUI

struct PortfolioView: View {
    
   
    @EnvironmentObject var portfolioViewModel:PortfolioModel
    
    var body: some View {
        
        
        Section(header: Text("Portfolio")){
            
            HStack{
                VStack(alignment: .leading){
                    Text("Net Worth")
                        .font(.title3)
                    let curr_net_balance:Double = portfolioViewModel.getNetWorth()
                    
                    
                    Text("$\(curr_net_balance, specifier:"%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Cash Balance")
                        .font(.title3)
                    
                    
                    let curr_balance:Double = portfolioViewModel.getBalance()
                    Text("$\(curr_balance, specifier:"%.2f")")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            
            
            
            ForEach(portfolioViewModel.portfolioArray, id:\.self){
                element in
//                ForEach(portfolioViewModel.portfolioArray[element]){
//                    key, value in
//                    NavigationLink(destination: DetailsView(ticker:key)
//                }
//                ForEach(portfolioViewModel.portfolioArray[0]){
//                    tr in
//                    Text(tr)
//                }
                let key_arr = Array(element.keys)[0]
                let val_arr = Array(element.values)
                let x = val_arr[0]
                let qty = x.Quantity
                let mkt_value = x.Market_Value
                let change = round(x.User_Holdings_Change*100)/100.0
                let change_perc = x.Portfolio_Change_Percent
                let _ = print("element", Array(element.keys)[0], Array(element.values)[0])
                NavigationLink(destination: DetailsView(ticker:key_arr))
        {
            VStack {
                    HStack {
                     VStack(alignment: .leading) {
                            Text(key_arr)
                                .font(.title3)
                                .fontWeight(.bold)
                         Text("\(qty)")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.gray)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(mkt_value, specifier:"%.2f")")
                                .font(.title3)
                                .fontWeight(.bold)
                            HStack{
                                
//                                let change:Float=Float(10) ?? 0
                                
                                if change==0{
                                    Image(systemName: "minus")
                                        .foregroundColor(Color.gray)
                                    Text("$\(change, specifier:"%.2f") (\(change_perc, specifier:"%.2f")%)").foregroundColor(Color.gray)
                                }
                                
                                else if  change>0{
                                    Image(systemName: "arrow.up.right")
                                        .foregroundColor(Color.green)
                                    Text("$\(change, specifier:"%.2f") (\(change_perc, specifier:"%.2f")%)").foregroundColor(Color.green)
                                    
                                }
                                else{
                                    
                                    Image(systemName: "arrow.down.forward")
                                        .foregroundColor(Color.red)
                                    Text("$\(change, specifier:"%.2f") (\(change_perc, specifier:"%.2f")%)").foregroundColor(Color.red)
                                    
                                }
                                
                                
                            }
                        }
                        
                    }
                    
                    }
                
            }
            
        }
        .onMove (perform:portfolioViewModel.moveItem )
            
        }
    }
        

}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
