//
//  NewsView.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI
import Kingfisher

struct NewsView: View {
    @ObservedObject var companyViewModel:CompanyProfileModel
    @Binding var showNewsSheet:Bool
    var body: some View {
        
        VStack{
            HStack{
                Text("News")
                    .font(.title)
                    .fontWeight(.medium)

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)

            VStack(alignment:.leading){
                Button(action: {
                    showNewsSheet.toggle()

                },
                       label:

                           {

                    VStack(alignment:.leading){
                    KFImage(URL(string: companyViewModel.NewsArray[0].image))
                                                .resizable()
                                                .frame( height: 250)
                                                .scaledToFill()
                                                .cornerRadius(15)
                    Text(companyViewModel.NewsArray[0].source_datetime)
                        .foregroundColor(Color.gray)
                        .fontWeight(.bold)
                        .padding(.leading)

                Text(companyViewModel.NewsArray[0].headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .font(.headline)
               }
                }

                )
                 .sheet(isPresented: $showNewsSheet, content: {

                    NewsScreen(news_source:companyViewModel.NewsArray[0].source,
                               news_source_datetime:self.$companyViewModel.NewsArray[0].source_datetime,
                               news_summary:companyViewModel.NewsArray[0].summary,
                               news_headline:companyViewModel.NewsArray[0].headline,
                               sheet_news_url:companyViewModel.NewsArray[0].news_url

                    )

                }
                )

            Divider()

            ForEach((1...companyViewModel.NewsArray.count-1), id:\.self){ index in
//                         let _ = print("news index", index)

                Button(action: {
                    showNewsSheet.toggle()

                },
                       label: {


                    HStack{
                        VStack(alignment:.leading){
//                                     let temp_str:String = "\(companyViewModel.NewsArray[index].source) \(companyViewModel.NewsArray[index].difference)"
                            Text(companyViewModel.NewsArray[index].source_datetime)
                            .foregroundColor(Color.gray)
                            .fontWeight(.bold)
                            .padding(.leading)

                        Text(companyViewModel.NewsArray[index].headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                            .font(.headline)

                        }
                        Spacer()

                        KFImage(URL(string: companyViewModel.NewsArray[index].image))
                                                    .resizable()
                                                    .frame(width:100, height: 100)
                                                    .scaledToFit()
                                                    .cornerRadius(15)
                    }

                })

                .sheet(isPresented: $showNewsSheet, content: {
//                    let _ = print("news sheet", companyViewModel.NewsArray[index].source_datetime)
                    NewsScreen(news_source:companyViewModel.NewsArray[index].source,
                               news_source_datetime:self.$companyViewModel.NewsArray[index].source_datetime,
                               news_summary:companyViewModel.NewsArray[index].summary,
                               news_headline:companyViewModel.NewsArray[index].headline,
                               sheet_news_url:companyViewModel.NewsArray[index].news_url

                    )

                }
                )


            }



        }
        .padding([.trailing,.leading], 12)
            


       }
        .padding([.leading], 12)
    }
}

//struct NewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsView()
//    }
//}
