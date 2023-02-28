//
//  CompanyProfileModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 20/04/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct CompanyProfileKeys:Identifiable{
    let id:String = UUID().uuidString
    let finnhubIndustry:String
    let ipo:String
    let logo:String
    let name:String
    let weburl:String
}




class CompanyProfileModel:ObservableObject{
    

    @Published var ProfileArray: [CompanyProfileKeys] = []
    @Published var StockPriceArray: [StockPriceKeys] = []
    @Published var PeersArray: [PeersKey] = []
    @Published var SentimentsArray: [SentimentKeys] = []
    @Published var NewsArray: [NewsKeys] = []
    @Published var isLoading: Bool = false

    func getAllData(ticker:String)
    {
        self.isLoading = true
        getCompanyProfile(ticker: ticker)
        getStockPrice(ticker:ticker)
        getPeers(ticker:ticker)
        getSentiments(ticker:ticker)
        getNews(ticker:ticker)
    }
    
    func secondsToHoursMinutes(_ seconds: Int) -> String {
        
        return "\(seconds / 3600) hr, \((seconds % 3600) / 60) min"
        
    }

    func getCompanyProfile(ticker:String){
        
        AF.request("https://backend-hw8-ss.uw.r.appspot.com/getcompanyProfile", parameters:["ticker":ticker]).responseJSON{
            (response) in
            
            switch response.result{
            case .success:
                guard let response_data = response.data else{
                    return
                }
                do{
                    let json = try JSON(data: response_data)
                  
                    self.ProfileArray.append(CompanyProfileKeys(
                        finnhubIndustry:json["data"]["finnhubIndustry"].stringValue,
                        ipo:json["data"]["ipo"].stringValue,
                        logo:json["data"]["logo"].stringValue,
                        name:json["data"]["name"].stringValue,
                        weburl:json["data"]["weburl"].stringValue
                    ))
                }
                
                catch{
                    print("Profile Error")
                }
                

                
                break
            case .failure:
                break
                
            }
            

      }

    }
    
    func getStockPrice(ticker:String){
       

            AF.request("https://backend-hw8-ss.uw.r.appspot.com/getStockPrice", parameters:["ticker":ticker]).responseJSON{
            (response) in
                switch response.result{
                case .success:

                    guard let response_data = response.data else{
                        return
                    }
                    do{
                        let json = try JSON(data: response_data)
                    self.StockPriceArray.append(StockPriceKeys(
                        ticker:ticker,
                        name:"",
                    Last_Price:json["data"]["c"].stringValue,
                    Change:json["data"]["d"].stringValue,
                    Change_Percentage:json["data"]["dp"].stringValue,
                    High_Price:json["data"]["h"].stringValue,
                    Low_Price:json["data"]["l"].stringValue,
                    Open_Price:json["data"]["o"].stringValue,
                    Prev_Close:json["data"]["pc"].stringValue,
                    Timestamp: json["data"]["t"].stringValue
                ))
                    }
                    
                    catch{
                        print("Stocks Error")
                    }
                
                    
                    break
                    
                case .failure:
                    break
                    
            }
            }

    }
    
    
   
    
    func getPeers(ticker:String){
        
        AF.request("https://backend-hw8-ss.uw.r.appspot.com/getCompanyPeers", parameters:["ticker":ticker]).responseJSON{
            (response) in
            
            switch response.result{
            case .success:

                guard let response_data = response.data else{
                    return
                }
                do{
                    let json = try JSON(data: response_data)

                    self.PeersArray.append(
                    PeersKey(peers:json["data"].rawValue as! [String])
                    )
                }
                
                catch{
                    print("Peers Error")
                }
                

                    

                break
            case .failure:
                break
                
            }
            
            
           
                
                
            

            
//            self.isLoading = false
      }
    }
    
    func getSentiments(ticker:String){

        AF.request("https://backend-hw8-ss.uw.r.appspot.com/getInsightsSentiment", parameters:["ticker":ticker]).responseJSON{
            (response) in
            
            switch response.result{
            case .success:
                guard let response_data = response.data else{
                    return
                }
                do{
                    let json = try JSON(data: response_data)
                    self.SentimentsArray.append(
                    SentimentKeys(
                        reddit_metions:json["data"]["reddit"]["mentions"].stringValue,
                        reddit_positive:json["data"]["reddit"]["positive"].stringValue,
                        reddit_negative:json["data"]["reddit"]["negative"].stringValue,
                        twitter_metions:json["data"]["twitter"]["mentions"].stringValue,
                        twitter_positive:json["data"]["twitter"]["positive"].stringValue,
                        twitter_negative:json["data"]["twitter"]["negative"].stringValue
                    )
                    )
                }
                catch{
                    print("Sentiments Error")
                }
                    

                break
            case .failure:
                break
                
            }
            

      }
    }
    
    func getNews(ticker:String){
        
        AF.request("https://backend-hw8-ss.uw.r.appspot.com/getCompanyNews", parameters:["ticker":ticker]).responseJSON{
            (response) in
            
            switch response.result{
            case .success:
                guard let response_data = response.data else{
                    return
                }
                do{
                    let json = try JSON(data: response_data)

                    for (key,value) in json["data"]{
                        let timestamp = Int(NSDate().timeIntervalSince1970)
                        let diff =  timestamp - value["datetime"].intValue
                    self.NewsArray.append(NewsKeys(
                        datetime:value["datetime"].stringValue,
                        headline:value["headline"].stringValue,
                        image:value["image"].stringValue,
                        source:value["source"].stringValue,
                        summary:value["summary"].stringValue,
                        news_url:value["url"].stringValue,
                        source_datetime:"\(value["source"].stringValue) \(self.secondsToHoursMinutes(diff))"
                    ))
                        self.isLoading = false
                }
                }
                
                catch{
                    print("News Error")
                }
                
                break
            case .failure:
                break
                
            }

      }

    }
    
}
 
