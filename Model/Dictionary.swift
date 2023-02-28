//import Foundation
//
//struct tPortfolioKeys:Identifiable, Codable{
//    var id:String = UUID().uuidString
//    var Quantity:Int
//    var Total_Cost:Double
//    var Avg_Cost:Double
//    var Portfolio_Last_Price:Double
//    var User_Holdings_Change:Double
//    var Market_Value:Double
//    var Portfolio_Change:Double
//    var Portfolio_Change_Percent:Double
//
//    
//}
//
//class tPortfolioModel{
//  var arr:[String] = []
//
//  var portfolioArray: [[String:tPortfolioKeys]] = []
//
//  func abc(){
// 
//    var temp:[String:tPortfolioKeys] = [:]
//    var temp2:[String:tPortfolioKeys] = [:]
//  
//  
//    
//    temp["AAPL"] = tPortfolioKeys(
//
//                Quantity: 3,
//                Total_Cost: 2.2,
//                Avg_Cost: 2.2,
//                Portfolio_Last_Price: 2.2,
//                User_Holdings_Change: 2.2,
//                Market_Value: 2.2,
//                Portfolio_Change:2.2 ,
//                Portfolio_Change_Percent:2.2
//    )
//
//    temp2["TSLA"] = tPortfolioKeys(
//
//                Quantity: 3,
//                Total_Cost: 2.2,
//                Avg_Cost: 2.2,
//                Portfolio_Last_Price: 2.2,
//                User_Holdings_Change: 2.2,
//                Market_Value: 2.2,
//                Portfolio_Change:2.2 ,
//                Portfolio_Change_Percent:2.2
//    )
//      self.portfolioArray.append(
//          temp
//      )
//      self.portfolioArray.append(
//          temp2
//      )
//
//      for element in self.portfolioArray{
//        
//        let keyExists = element["AAPL"] != nil
//        if keyExists{
//          print("hi",element["AAPL"])
//        }
//        
//      }
//  
//
//  
//  }
//
//
//
//}
//
//
//

//import Foundation
//
//struct PortfolioKeys:Identifiable, Codable{
//    var id:String = UUID().uuidString
//    var tQuantity:Int
//    var Total_Cost:Double
//    var Avg_Cost:Double
//    var Portfolio_Last_Price:Double
//    var User_Holdings_Change:Double
//    var Market_Value:Double
//    var Portfolio_Change:Double
//    var Portfolio_Change_Percent:Double
//
//
//}
//struct User {
//
//    let first: String
//    let last: String
//
//}
//
//class PortfolioModel{
//  var arr:[String] = []
//
//  // var d:[[String:PortfolioKeys]] = NSMutableDictionary
//
//  var portfolioArray: [[String:PortfolioKeys]] = []
//
//
//
//  init(){
////     let users: [User] = [
////     User(first: "Lucy", last: "Johnson"),
////     User(first: "John", last: "Williams")
//// ]
//// let re = users.first!
//// if ("Lucy" in re){
//// print("re",re)
//// }
//
//// if "Lucy" in re{
//
//// }
//
//
//    var temp:[String:PortfolioKeys] = [:]
//    var temp2:[String:PortfolioKeys] = [:]
//
//
//
//    temp["AAPL"] = PortfolioKeys(
//
//                tQuantity: 10,
//                Total_Cost: 2.2,
//                Avg_Cost: 2.2,
//                Portfolio_Last_Price: 2.2,
//                User_Holdings_Change: 2.2,
//                Market_Value: 2.2,
//                Portfolio_Change:2.2 ,
//                Portfolio_Change_Percent:2.2
//    )
//
//    temp2["TSLA"] = PortfolioKeys(
//
//                tQuantity: 20,
//                Total_Cost: 2.2,
//                Avg_Cost: 2.2,
//                Portfolio_Last_Price: 2.2,
//                User_Holdings_Change: 2.2,
//                Market_Value: 2.2,
//                Portfolio_Change:2.2 ,
//                Portfolio_Change_Percent:2.2
//    )
//      self.portfolioArray.append(
//          temp
//      )
//      self.portfolioArray.append(
//          temp2
//      )
//
//  }
//
//  func abc(ticker:String,quantity:Int){
//
//    var counter:Int = 0
//    var flag:Bool = false
//
//      for element in self.portfolioArray.indices{
//        // print("he", self.portfolioArray[element]["AAPL"])
//        // print(element)
//        counter+=1
//
//        let keyExists = self.portfolioArray[element][ticker] != nil
//        // print("keyExists",keyExists)
//        if keyExists{
//          // print("hww")
//          flag = true
//
//          let f = self.portfolioArray[element][ticker]?.tQuantity ?? 0
//
//
//        self.portfolioArray[element][ticker]?.tQuantity = f + quantity
//        break
//
//        }
//
//
//
//      }
//
//      //  print("why")
//      if (!flag && counter>=self.portfolioArray.count){
//var temp3:[String:PortfolioKeys] = [:]
//          temp3[ticker] = PortfolioKeys(
//
//                tQuantity: quantity,
//                Total_Cost: 2.2,
//                Avg_Cost: 2.2,
//                Portfolio_Last_Price: 2.2,
//                User_Holdings_Change: 2.2,
//                Market_Value: 2.2,
//                Portfolio_Change:2.2 ,
//                Portfolio_Change_Percent:2.2
//    )
//
//    self.portfolioArray.append(temp3)
//      }
//
//
//  // print("final",self.portfolioArray)
//
//  }
//
//  func checkSell(ticker:String, quantity:Int)->Bool{
//
//  for element in self.portfolioArray.indices{
//
//    let keyExists = self.portfolioArray[element][ticker] != nil
//        // print("keyExists",keyExists)
//        if keyExists{
//          let f = self.portfolioArray[element][ticker]?.tQuantity ?? 0
//
//          if quantity>f{
//            return false
//          }
//
//        return true
//        }
//
//  }
//  return false
//  }
//
//  func SellStock(ticker:String, quantity:Int){
//
//
//
//
//
//    for element in self.portfolioArray.indices{
//      let keyExists = self.portfolioArray[element][ticker] != nil
//        print("keyExists",type(of:self.portfolioArray[element].keys))
//        if keyExists{
//          let f = self.portfolioArray[element][ticker]?.tQuantity ?? 0
//          let diff = f - quantity
//          if (diff<=0){
//            self.portfolioArray[element]
//            .removeValue(forKey: ticker)
//            self.portfolioArray.remove(at: element)
//          }
//          else{
//            self.portfolioArray[element][ticker]?.tQuantity = diff
//          }
//
//
//        break
//
//        }
//    }
//
//
//
//
//  }
//
//
//
//}
//var x = PortfolioModel()
//x.abc(ticker:"DELL", quantity:30)
//x.abc(ticker:"AAPL", quantity:100)
//x.abc(ticker:"DELL", quantity:300)
//let ans = x.checkSell(ticker: "AAPL", quantity: 10)
//print(ans)
//x.SellStock(ticker: "TSLA", quantity: 20)
//print(x.portfolioArray)
