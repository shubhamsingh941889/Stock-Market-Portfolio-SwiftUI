//
//  AboutView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI

struct AboutView: View {
    @ObservedObject var companyViewModel:CompanyProfileModel
    var body: some View {
        
        VStack {
            HStack{
                Text("About")
                    .font(.title)
                    .fontWeight(.medium)

            }
            .frame(maxWidth: .infinity, alignment: .leading)


            HStack{
                VStack(alignment: .leading){
                    Text("IPO Start Date: ")
                        .fontWeight(.semibold)
                        .padding(.bottom,0.5)
                    Text("Industry: ")
                            .fontWeight(.semibold)
                            .padding(.bottom,0.5)
                    Text("Webpage: ")
                            .fontWeight(.semibold)
                            .padding(.bottom,0.5)
                    Text("Peers: ")
                            .fontWeight(.semibold)
                            .padding(.bottom,0.5)

                }
                .padding(.top,0.5)
                Spacer()
                VStack(alignment: .leading){
                           
                    Text(companyViewModel.ProfileArray[0].ipo)
                        .padding(.bottom,0.5)
                    Text(companyViewModel.ProfileArray[0].finnhubIndustry)
                        .padding(.bottom,0.5)
                    
                    if let temp_url = companyViewModel.ProfileArray[0].weburl
                    {

                    Link(companyViewModel.ProfileArray[0].weburl, destination: URL(string: temp_url)!)
                            .padding(.bottom,0.5)
                            .multilineTextAlignment(.trailing)
                    }
                       

                    ScrollView(.horizontal){
                    VStack {
                                    HStack(spacing: 10) {
                                        ForEach(companyViewModel.PeersArray[0].peers, id:\.self) { index in
//                                                     let _ = print("idx",index)
                                            NavigationLink(destination: DetailsView(ticker: index)){
//                                                         let all_peers:String = "\(index), "
                                                Text(index+",")
                                                    .foregroundColor(Color.blue)
                                            }
                                        }
                                    }

                            }
                    }
                        
                    
                
            }
                .padding(.top,0.5)
                Spacer()
            }
  }

        .padding([.leading], 12)
    }
}

//struct AboutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AboutView()
//    }
//}
