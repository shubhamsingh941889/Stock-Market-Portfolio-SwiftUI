//
//  FavoritesModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 27/04/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON


class FavoritesModel: ObservableObject{
    

    
    @Published var favoritesArray: [[String:StockPriceKeys]] = []{
        didSet{
            saveFavorites()
            
        }
    }
    let favoritesKey: String = "fav_list"
    
    init(){
        getFavorites()
//        self.favoritesArray = []
     
    }
 
    func getFavorites(){
        guard
            let data = UserDefaults.standard.data(forKey: favoritesKey),
            let savedFavorites = try? JSONDecoder().decode([[String:StockPriceKeys]].self, from: data)
        else {return}
        self.favoritesArray = savedFavorites
        
        
    }
    
    func deleteFavorites(ticker:String){
        for element in self.favoritesArray.indices{
            let keyExists = self.favoritesArray[element][ticker] != nil
            if keyExists{
                self.favoritesArray[element]
                            .removeValue(forKey: ticker)
                self.favoritesArray.remove(at: element)
                break
            }
            
        }
    }
    
    func moveItem(from:IndexSet, to:Int){
        
        self.favoritesArray.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteItem(indexSet:IndexSet){
        self.favoritesArray.remove(atOffsets: indexSet)
    }
    
    func checkFavExists(ticker:String)->Bool{

      for element in self.favoritesArray.indices{

        let keyExists = self.favoritesArray[element][ticker] != nil
            // print("keyExists",keyExists)
            if keyExists{
              
            return true
            }
      
      }
      return false
      }
    
//    func getLatestFavorites(){
//        var ticker_arr:[String] = []
//        for element in self.favoritesArray{
//            ticker_arr.append(element.ticker)
//        }
//        self.favoritesArray = []
//
//        for ticker in ticker_arr{
//
//            AF.request("https://backend-hw8-ss.uw.r.appspot.com/getStockPrice", parameters:["ticker":ticker]).responseJSON{
//                (response) in
//    //                print("in stock",self.ticker)
//                    switch response.result{
//                    case .success:
//
//
//                        let json = try! JSON(data: response.data!)
//
//                 var newItem = StockPriceKeys(
//                ticker:ticker,
//                name:"",
//            Last_Price:json["data"]["c"].stringValue,
//            Change:json["data"]["d"].stringValue,
//            Change_Percentage:json["data"]["dp"].stringValue,
//            High_Price:json["data"]["h"].stringValue,
//            Low_Price:json["data"]["l"].stringValue,
//            Open_Price:json["data"]["o"].stringValue,
//            Prev_Close:json["data"]["pc"].stringValue,
//                Timestamp: json["data"]["t"].stringValue
//                )
//                        AF.request("https://backend-hw8-ss.uw.r.appspot.com/getcompanyProfile", parameters:["ticker":ticker]).responseData{
//                            (response) in
//
//                            switch response.result{
//                            case .success:
//
//                                let json = try! JSON(data: response.data!)
//                                newItem.name = json["data"]["name"].stringValue
//                                self.favoritesArray.append(newItem)
//
//                                break
//                            case .failure:
//                                break
//                            }
//                        }
//
//                        break
//
//                    case .failure:
//                        break
//
//
//            }
//
//
//
//            }
//
//        }
//    }
    
    func addFavorites(ticker:String, name:String){
//        var newItem: StockPriceKeys = StockPriceKeys
        self.getFavorites()

            
            AF.request("https://backend-hw8-ss.uw.r.appspot.com/getStockPrice", parameters:["ticker":ticker]).responseJSON{
                (response) in
    //                print("in stock",self.ticker)
                    switch response.result{
                    case .success:
                        
                        guard let response_data = response.data else{
                            return
                        }

                    
                        do{
                            let json = try JSON(data: response_data)
                            
                            var temp:[String:StockPriceKeys] = [:]
                            temp[ticker] = StockPriceKeys(
                           ticker:ticker,
                           name:name,
                       Last_Price:json["data"]["c"].stringValue,
                       Change:json["data"]["d"].stringValue,
                       Change_Percentage:json["data"]["dp"].stringValue,
                       High_Price:json["data"]["h"].stringValue,
                       Low_Price:json["data"]["l"].stringValue,
                       Open_Price:json["data"]["o"].stringValue,
                       Prev_Close:json["data"]["pc"].stringValue,
                           Timestamp: json["data"]["t"].stringValue
                           )
                            
                            self.favoritesArray.append(temp)
                                   
                                   
                            break
                        }
                        
                        catch{
                            print("Portfolio Error")
                        }
                        
                        
            
                 
                        
                    case .failure:
                        break
                

            }

            
            
            }
        
        
        
                    
    }
    
    func getLatestFavorites(){
        
        for element in self.favoritesArray.indices{

        let ticker = Array(self.favoritesArray[element].keys)[0]
            
            AF.request("https://backend-hw8-ss.uw.r.appspot.com/getStockPrice", parameters:["ticker":ticker]).responseJSON{
                (response) in
    //                print("in stock",self.ticker)
                    switch response.result{
                    case .success:
                        
                        guard let response_data = response.data else{
                            return
                        }

                    
                        do{
                            let json = try JSON(data: response_data)
                            
                            self.favoritesArray[element][ticker]?.Last_Price = json["data"]["c"].stringValue
                            self.favoritesArray[element][ticker]?.Change = json["data"]["d"].stringValue
                            self.favoritesArray[element][ticker]?.Change_Percentage = json["data"]["dp"].stringValue
                            self.favoritesArray[element][ticker]?.High_Price = json["data"]["h"].stringValue
                            self.favoritesArray[element][ticker]?.Low_Price = json["data"]["l"].stringValue
                            self.favoritesArray[element][ticker]?.Open_Price = json["data"]["o"].stringValue
                            self.favoritesArray[element][ticker]?.Prev_Close = json["data"]["pc"].stringValue
                            self.favoritesArray[element][ticker]?.Timestamp = json["data"]["t"].stringValue
                            
                            
                                   
                                   
                            break
                        }
                        
                        catch{
                            print("Portfolio Error")
                        }
                        
                        
            
                 
                        
                    case .failure:
                        break
                

            }

            
            
            }
        
        
        }
        
    }
    
    func saveFavorites(){

        if let encodedData = try? JSONEncoder().encode(self.favoritesArray){
            UserDefaults.standard.set(encodedData,forKey: favoritesKey)
        }
        
    }

}
