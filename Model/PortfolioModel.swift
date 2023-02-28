//
//  PortfolioModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 02/05/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct PortfolioKeys:Identifiable, Codable, Hashable{
    var id:String = UUID().uuidString
    var Quantity:Int
    var Total_Cost:Double
    var Avg_Cost:Double
    var Portfolio_Last_Price:Double
    var User_Holdings_Change:Double
    var Market_Value:Double
    var Portfolio_Change_Percent:Double

    
}

class PortfolioModel:ObservableObject{
    
    @Published var portfolioArray: [[String:PortfolioKeys]] = []{
        didSet{
            savePortfolio()
            
        }
    }
    
    
    @Published var Balance:Double = 25000{
        didSet{
            saveCash()
        }
    }
    @Published var Net_Worth:Double = 25000{
        didSet{
            saveNetWorth()
        }
    }
    
    
    let PortfolioSaveKey: String = "portfolio_list"
    let CashSaveKey: String = "cash"
    let NetWorthSaveKey: String = "networth"
    
    init(){
        getSavedCash()
        getSavedNetWorth()
        getPortfolio()
        
        
//        self.portfolioArray = []
//        self.Balance = 25000
//        self.Net_Worth = 25000

    }
 
    func getBalance()->Double{
        return self.Balance
    }
    
    func setBalance(value:Double, type:String){
        if type=="Buy"{
            self.Balance -= value
        }
        
        else if type=="Sell"{
            self.Balance += value
        }
        
    }
    
    func getNetWorth()->Double{
        return self.Net_Worth
    }
    
    func setNetWorth(){
        var sum_mkt_val:Double = 0
        for element in self.portfolioArray{

            sum_mkt_val+=Array(element.values)[0].Market_Value
          
        }

        self.Net_Worth = self.Balance + sum_mkt_val
        
    }
    
    
    
  
    
    func getPortfolio(){
        guard
            let data = UserDefaults.standard.data(forKey: PortfolioSaveKey),
                let savedFavorites = try? JSONDecoder().decode([[String:PortfolioKeys]].self, from: data)
        else {return}
        self.portfolioArray = savedFavorites
        
        
    }
    
    func savePortfolio(){
        
        if let encodedData = try? JSONEncoder().encode(self.portfolioArray){
            UserDefaults.standard.set(encodedData,forKey: PortfolioSaveKey)
        }
        
    }
    
    func getSavedCash(){
        guard
            let data = UserDefaults.standard.data(forKey: CashSaveKey),
                let savedCash = try? JSONDecoder().decode(Double.self, from: data)
        else {return}
        self.Balance = savedCash
        
        
    }
    
    func saveCash(){
        
        if let encodedData = try? JSONEncoder().encode(self.Balance){
            UserDefaults.standard.set(encodedData,forKey: CashSaveKey)
        }
        
    }
    
    func getSavedNetWorth(){
        guard
            let data = UserDefaults.standard.data(forKey: NetWorthSaveKey),
                let savedNetWorth = try? JSONDecoder().decode(Double.self, from: data)
        else {return}
        self.Net_Worth = savedNetWorth
        
        
    }
    
    func saveNetWorth(){
        
        if let encodedData = try? JSONEncoder().encode(self.Net_Worth){
            UserDefaults.standard.set(encodedData,forKey: NetWorthSaveKey)
        }
        
    }
    
 
    
    func moveItem(from:IndexSet, to:Int){
//        print("arr",self.portfolioArray,"from",from, "to",to)
        self.portfolioArray.move(fromOffsets: from, toOffset: to)
    }
    
    func SellStock(ticker:String, quantity:Int){
        
        for element in self.portfolioArray.indices{
              let keyExists = self.portfolioArray[element][ticker] != nil
                // print("keyExists",keyExists)
                if keyExists{
                  let curr = self.portfolioArray[element][ticker]?.Quantity ?? 0
//                  let curr_price = self.portfolioArray[element][ticker]?.Portfolio_Last_Price ?? 0
                  let diff = curr - quantity
//                  let cuur_total_cost = (Double(diff) * curr_price)
                  if (diff<=0){
                      self.portfolioArray[element]
                                  .removeValue(forKey: ticker)
                      self.portfolioArray.remove(at: element)
                  }
                  else{
                    let curr_price = self.portfolioArray[element][ticker]?.Portfolio_Last_Price ?? 0
                    let cuur_total_cost = (Double(diff) * curr_price)
                    self.portfolioArray[element][ticker]?.Quantity = diff
                    self.portfolioArray[element][ticker]?.Total_Cost = cuur_total_cost
                    self.portfolioArray[element][ticker]?.Avg_Cost = cuur_total_cost / Double(diff)
                    self.portfolioArray[element][ticker]?.User_Holdings_Change = (curr_price - (cuur_total_cost / Double(diff)) )*Double(diff)
                    self.portfolioArray[element][ticker]?.Market_Value = cuur_total_cost
                    self.portfolioArray[element][ticker]?.Portfolio_Change_Percent = (
                        ((cuur_total_cost / Double(diff)) - curr_price)
                        /
                        cuur_total_cost
                    )*100
                      
                  }
                    

                break
                  
                }
            }
       
        
       
    }
    
    func checkSell(ticker:String, quantity:Int)->Bool{

      for element in self.portfolioArray.indices{

        let keyExists = self.portfolioArray[element][ticker] != nil
            // print("keyExists",keyExists)
            if keyExists{
              let curr = self.portfolioArray[element][ticker]?.Quantity ?? 0

              if quantity>curr{
                return false
              }

            return true
            }
      
      }
      return false
      }
    
    func getStockData(ticker:String)->PortfolioKeys?{

      for element in self.portfolioArray.indices{

        let keyExists = self.portfolioArray[element][ticker] != nil
            // print("keyExists",keyExists)
            if keyExists{
              
              // let s = self.portfolioArray[element][ticker]
              guard let data = self.portfolioArray[element][ticker] else{
                 break
              }
            return data
            }
      
      }
      return nil
       
      }

    
    
    
    func checkStockExists(ticker:String)->Bool{

      for element in self.portfolioArray.indices{

        let keyExists = self.portfolioArray[element][ticker] != nil
            // print("keyExists",keyExists)
            if keyExists{
              
            return true
            }
      
      }
      return false
      }
    
 
    
    func getLatestPortfolio(){

        for element in self.portfolioArray.indices{

        let ticker = Array(self.portfolioArray[element].keys)[0]
            
            self.Net_Worth = self.Balance
            
        
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
                      let current_price = json["data"]["c"].doubleValue
                        let curr_qty = self.portfolioArray[element][ticker]?.Quantity ?? 0
                        let cuur_total_cost = (Double(curr_qty) * current_price)
                        
                        self.portfolioArray[element][ticker]?.Total_Cost = cuur_total_cost
                        
                        let old_avg =
                        Double(self.portfolioArray[element][ticker]?.Avg_Cost ?? 0)
                        
                        self.portfolioArray[element][ticker]?.User_Holdings_Change = (current_price - old_avg)*Double(curr_qty)
                        
                        self.portfolioArray[element][ticker]?.Portfolio_Change_Percent =
                        (
                        (old_avg - current_price)
                        /
                        (self.portfolioArray[element][ticker]?.Total_Cost ?? 0)
                        )*100
                        
                        
                        self.portfolioArray[element][ticker]?.Avg_Cost =
                        (self.portfolioArray[element][ticker]?.Total_Cost ?? 0)
                        /
                        Double(curr_qty)
                            
                            
                            
                        self.portfolioArray[element][ticker]?.Portfolio_Last_Price = current_price
                        
                        
                        
//                                    (current_price - (cuur_total_cost / Double(quantity)))*Double(quantity)

                        
                        
                            
                            self.portfolioArray[element][ticker]?.Market_Value =
                            current_price
                            *
                            Double(curr_qty)
                        
//                                    ((cuur_total_cost / Double(quantity)) - current_price)
//                                    /
//                                    cuur_total_cost
//                                )*100
                            
                        
                        
                        
                        self.Net_Worth+=(self.portfolioArray[element][ticker]?.Market_Value ?? 0)
                        
                        
                       
                        
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
    
    
    func addPortfolio(ticker:String, quantity:Int){

        self.getPortfolio()
//        var curr_quantity:Int
        var cuur_total_cost:Double = 0

        var current_price:Double = 0
        var counter:Int = 0
        var flag:Bool = false
        



        
        
        for element in self.portfolioArray.indices{
            counter+=1
                    
                    let keyExists = self.portfolioArray[element][ticker] != nil
                    // print("keyExists",keyExists)
                    if keyExists{
                      // print("hww")
                      flag = true
                        
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
                                  current_price = json["data"]["c"].doubleValue
                                    cuur_total_cost = (Double(quantity) * current_price)
                                    
                                    self.portfolioArray[element][ticker]?.Quantity += quantity
                                    self.portfolioArray[element][ticker]?.Total_Cost += cuur_total_cost
                                    self.portfolioArray[element][ticker]?.Avg_Cost =
                                    (self.portfolioArray[element][ticker]?.Total_Cost ?? 0)
                                    /
                                    Double(self.portfolioArray[element][ticker]?.Quantity ?? 0 )
                                        
                                        
                                        
                                    self.portfolioArray[element][ticker]?.Portfolio_Last_Price = current_price
                                    
                                    let new_avg =
                                    Double(self.portfolioArray[element][ticker]?.Avg_Cost ?? 0)
                                    
//                                    (current_price - (cuur_total_cost / Double(quantity)))*Double(quantity)

                                    self.portfolioArray[element][ticker]?.User_Holdings_Change =
                                    
                                        (current_price - new_avg)*Double(self.portfolioArray[element][ticker]?.Quantity ?? 0 )
                                    
                                    
                                        
                                        self.portfolioArray[element][ticker]?.Market_Value =
                                        current_price
                                        *
                                        Double(
                                            self.portfolioArray[element][ticker]?.Quantity ?? 0)
                                    
//                                    ((cuur_total_cost / Double(quantity)) - current_price)
//                                    /
//                                    cuur_total_cost
//                                )*100
                                        
                                    self.portfolioArray[element][ticker]?.Portfolio_Change_Percent =
                                    (
                                    (new_avg - current_price)
                                    /
                                    (self.portfolioArray[element][ticker]?.Total_Cost ?? 0)
                                    )*100
                                    
                                    
                                    
                                   
                                    
                                    break
                                }
                                
                                catch{
                                    print("Portfolio Error")
                                }
                  
                            case .failure:
                                break

                    }
                    }

                    
                    
                        
                    break

                    }
            
        }
        
//        print("flag", flag, counter)
        
        if (!flag && counter>=self.portfolioArray.count){
            
            
            
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
                        var temp:[String:PortfolioKeys] = [:]
                      current_price = json["data"]["c"].doubleValue
//                                    print("in current_price",self.current_price)
                        cuur_total_cost = (Double(quantity) * current_price)
                        
                        temp[ticker] = PortfolioKeys(
                                        Quantity: quantity,
                                        Total_Cost: cuur_total_cost,
                                        Avg_Cost: cuur_total_cost / Double(quantity),
                                        Portfolio_Last_Price: current_price,
                                        User_Holdings_Change: (current_price - (cuur_total_cost / Double(quantity)))*Double(quantity),
                                        Market_Value: cuur_total_cost,
                                        Portfolio_Change_Percent:(
                                            ((cuur_total_cost / Double(quantity)) - current_price)
                                            /
                                            cuur_total_cost
                                        )*100
                            )
                        
                        self.portfolioArray.append(temp)
                        
                       
                        
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
    
    
    
}
