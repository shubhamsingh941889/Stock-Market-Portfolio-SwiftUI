//
//  StatsView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var companyViewModel:CompanyProfileModel
    var body: some View {
        
        
        VStack {
            HStack{
                Text("Stats")
                    .font(.title)
                    .fontWeight(.medium)

            }
            .frame(maxWidth: .infinity, alignment: .leading)


            HStack{
                let High_Price:Double=Double(companyViewModel.StockPriceArray[0].High_Price) ?? 0

            Text("High Price: ")
                    .fontWeight(.semibold)
                +
                Text("$\(High_Price, specifier:"%.2f")")


                Spacer()

                let Open_Price:Double=Double(companyViewModel.StockPriceArray[0].Open_Price) ?? 0
                Text("Open Price: ").fontWeight(.semibold)
                +
                Text("$\(Open_Price, specifier:"%.2f")")

                Spacer()
                Spacer()
                Spacer()



            
            }
//                     .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,0.5)

            HStack{
             let Low_Price:Double=Double(companyViewModel.StockPriceArray[0].Low_Price) ?? 0

            Text("Low Price: ")
                    .fontWeight(.semibold)
                +
                Text("$\(Low_Price, specifier:"%.2f")")


                Spacer()

                let Prev_Close:Double=Double(companyViewModel.StockPriceArray[0].Prev_Close) ?? 0
                Text("Prev Price: ").fontWeight(.semibold)
                +
                Text("$\(Prev_Close, specifier:"%.2f")")

                Spacer()
                Spacer()
                Spacer()


            
            }
//                     .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,0.5)




        }

        .padding([.trailing,.leading], 12)
        .padding(.bottom, 20)
    }
}

//struct StatsView_Previews: PreviewProvider {
//    @ObservedObject var companyViewModel:CompanyProfileModel
//    static var previews: some View {
//        StatsView(companyViewModel:companyViewModel)
//    }
//}
