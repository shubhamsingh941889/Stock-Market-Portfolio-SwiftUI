//
//  SearchModel.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 18/04/22.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

struct SearchKeys:Identifiable{
    let id:String = UUID().uuidString
    let description:String
    let symbol:String
}

class SearchModel:ObservableObject{
//    @Published var searchText: String = ""
    @Published var autoCompleteArray: [SearchKeys] = []
//    @Published var isLoading: Bool = false
//    @Published var temp: String = ""
    let debouncer = Debouncer(delay:2)
    
    func updateArray(){
        self.autoCompleteArray = []
    }
    func updateAutoComplete(newValue:String){
        
        
//        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            self.debouncer.run(action: {
                        AF.request("https://backend-hw8-ss.uw.r.appspot.com/performAutoComplete", parameters:["queryName":newValue.uppercased()]).responseData{
                            (data) in
//                            print("ticker",newValue)
                            switch data.result{
                            case .success:
                            let json = try! JSON(data: data.data!)
                            for i in json{
                                for j in i.1{
//                                    print("jaaa",j.1["symbol"])
                                    self.autoCompleteArray.append(SearchKeys(description:j.1["description"].stringValue,symbol:j.1["symbol"].stringValue))
//                                    print("auto",self.autoCompleteArray)
                                }
                            }
                                break
                            case .failure:
                                break
                                
                            }
//                            self.isLoading = false
                            
                      }
                    })
                })
//        print("auto",self.autoCompleteArray)
    }
   
}
 



