//
//  NewsScreen.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 01/05/22.
//

import SwiftUI
import Kingfisher

struct NewsScreen: View{
    
    @SwiftUI.Environment(\.presentationMode) var presentationMode

    let news_source:String
    @Binding var news_source_datetime:String
    let news_summary:String
    let news_headline:String
    let sheet_news_url:String

    
    
    
    var body: some View{
//        let _ = print("newsidx",idx)
        ZStack{

            VStack{
                
                
                HStack {
                
            Spacer()

        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.black)
                .font(.headline)
                
                .padding(20)
            
        })
                    
            }
                HStack{
                    
                    
                Text(news_source)
                    .fontWeight(.bold)
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading)
                    .font(.title)
                    Spacer()
                }
                .padding([.leading], 12)
                HStack{
                Text(news_source_datetime)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
//                    .multilineTextAlignment(.leading)
//                    .padding(.leading)
                    .font(.headline)
                    Spacer()
                }
                .padding([.leading], 12)
                Divider()
                HStack{
                    Text(news_headline)
                        .fontWeight(.bold)
                        .font(.title3)
//                        .multilineTextAlignment(.leading)
                }
                .padding(.leading, 2)
                
                
                HStack{
                    Text(news_summary)
                        .fontWeight(.semibold)
//                        .foregroundColor(Color.black)
//                        .font(.title3)
                }
                .padding([.leading], 12)
                HStack{
                    Text("For more details click")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.gray)
                        .padding(.leading, 12)
                    if let temp_url = sheet_news_url{
                    Link("here", destination: URL(string: temp_url)! )
                    }
                    
                    Spacer()
                    
                   //                                 .padding(.bottom,0.5)
                }
                HStack{
//                    let _ = print("head",headline.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
//                    let _ = print("url",fburl)
                    
                    if let temp_url = sheet_news_url{
                    Link(destination: URL(string: "https://twitter.com/intent/tweet?text=\(String(describing: news_headline.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!))&url=\(temp_url)")!){
                        Image("twitter_logo")
                            .resizable()
                            .frame(width:60, height: 60)
                    }
                    }
                    if let temp_url = sheet_news_url{
                    Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(temp_url)")!){
                        Image("facebook_logo")
                            .resizable()
                            .frame(width:60, height: 60)
                    }
                    }
                    Spacer()
                }
                .padding([.leading], 12)
                Spacer()
                
 
            }
           
            
        }
       
    }
}



//struct NewsScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsScreen()
//    }
//}
