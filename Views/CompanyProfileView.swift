//
//  CompanyProfileView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI
import Kingfisher

struct CompanyProfileView: View {
    @ObservedObject var companyViewModel:CompanyProfileModel
    var body: some View {
        HStack{
            
            Text(companyViewModel.ProfileArray[0].name)
                .foregroundColor(Color.gray)
            Spacer()
            KFImage(URL(string: companyViewModel.ProfileArray[0].logo))
                .resizable()
                .frame(width: 50, height: 50)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding([.leading, .trailing], 12)
        
        
        
        HStack(){
            let Last_Price:Double=Double(companyViewModel.StockPriceArray[0].Last_Price) ?? 0

            Text("$\(Last_Price, specifier:"%.2f")")
                .font(.title)
                .fontWeight(.bold)

            let change:Double=Double(companyViewModel.StockPriceArray[0].Change) ?? 0
            let change_percent:Double = Double(companyViewModel.StockPriceArray[0].Change_Percentage) ?? 0

            if  change>0{
                Image(systemName: "arrow.up.right")
                    .foregroundColor(Color.green)
                Text("$\(change_percent,specifier: "%.2f") (\(change,specifier: "%.2f")%)").foregroundColor(Color.green)
            }
            else if change<0{
                Image(systemName: "arrow.down.forward")
                    .foregroundColor(Color.red)
                Text("$\(change_percent,specifier: "%.2f") (\(change,specifier: "%.2f")%)").foregroundColor(Color.red)
            }
            else{
                Text("$\(change_percent,specifier: "%.2f") (\(change,specifier: "%.2f")%)").foregroundColor(Color.red)
            }
            Spacer()
        
        }
        .frame(maxWidth: .infinity, maxHeight: 50)
        .padding([.leading], 12)
    }
}

//struct CompanyProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompanyProfileView(companyViewModel: companyViewModel)
//    }
//}
