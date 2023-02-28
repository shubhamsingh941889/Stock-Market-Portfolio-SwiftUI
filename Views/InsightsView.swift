//
//  InsightsView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject var companyViewModel:CompanyProfileModel
    var body: some View {
        VStack{
            HStack{
                Text("Insights")
                    .font(.title)
                    .fontWeight(.medium)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)

            HStack{
                Text("Social Sentiments")
                    .font(.title)
                    .fontWeight(.medium)


            }
            .padding(.top, 0.5)
            HStack{
                Group
                {
            VStack(alignment: .leading){
                Divider()
                Text(companyViewModel.ProfileArray[0].name)
                    .fontWeight(.bold)
                
                Divider()
                Text("Total\n Mentions")
                    .fontWeight(.bold)

                Divider()
                Text("Positive Mentions")
                    .fontWeight(.bold)

                Divider()

                Text("Negative Mentions")
                    .fontWeight(.bold)
                Divider()




            }
            }
                Spacer()
                VStack(alignment: .leading){
                    
                    Divider()
                    Text("Reddit")
                        .fontWeight(.bold)

                    Divider()
                    Text(companyViewModel.SentimentsArray[0].reddit_metions)
                        .padding(.vertical, 13)
                    Divider()
                    Text(companyViewModel.SentimentsArray[0].reddit_positive)
                        .padding(.vertical, 13)
                    Divider()
                    Text(companyViewModel.SentimentsArray[0].reddit_negative)
                        .padding(.vertical, 13)
                    Divider()
                }
                Spacer()
                VStack(alignment: .leading){
                    Divider()
                    Text("Twitter")
                        .fontWeight(.bold)

                    Divider()
                    Text(companyViewModel.SentimentsArray[0].twitter_metions)
                        .padding(.vertical, 13)


                    Divider()
                    Text(companyViewModel.SentimentsArray[0].twitter_positive)
                        .padding(.vertical, 13)
                    Divider()

                    Text(companyViewModel.SentimentsArray[0].twitter_negative)
                        .padding(.vertical, 13)
                    Divider()

                }
            }





        }
        .padding([.leading], 12)
    }
}

//struct InsightsView_Previews: PreviewProvider {
//    static var previews: some View {
//        InsightsView()
//    }
//}
