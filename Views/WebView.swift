//
//  JS.swift
//  StocksAppCS571
//
//  Created by Shubham Singh on 28/04/22.
//

import SwiftUI
import WebKit


class Coordinator : NSObject, WKNavigationDelegate {
    // ... any other code
    var parent: WebView
    init(view: WebView) {
        self.parent = view
        super.init()
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if parent.htmlfilename=="daily"{
//            let _ = print("web view",self.parent.timestamp, self.parent.change, self.parent.ticker)
//            let temp = "\(self.parent.ticker)"
        webView.evaluateJavaScript("DailyCharts(\"\(self.parent.ticker)\",\"\(self.parent.change)\",\"\(self.parent.timestamp)\");", completionHandler:{
            (response, error) in
                              if let error = error {
                                  print("Error calling javascript:DailyCharts()")
                                  print(error.localizedDescription)
                              } else {
                                  print("Called javascript:DailyCharts()")
                              }
            
        })
        }
        else if parent.htmlfilename=="historical"{
            webView.evaluateJavaScript("HistoricalChart('\(self.parent.ticker)');", completionHandler:{
            (response, error) in
                              if let error = error {
                                  print("Error calling javascript:HistoricalChart()")
                                  print(error.localizedDescription)
                              } else {
                                  print("Called javascript:HistoricalChart()")
                              }
            
        })
        }
        else if parent.htmlfilename=="insights"{
        webView.evaluateJavaScript("InsightsChart('\(self.parent.ticker)');", completionHandler:{
            (response, error) in
                              if let error = error {
                                  print("Error calling javascript:InsightsChart()")
                                  print(error.localizedDescription)
                              } else {
                                  print("Called javascript:InsightsChart()")
                              }
            
        })
        }
        else if parent.htmlfilename=="eps"{
        webView.evaluateJavaScript("EPSChart('\(self.parent.ticker)');", completionHandler:{
            (response, error) in
                              if let error = error {
                                  print("Error calling javascript:EPSChart()")
                                  print(error.localizedDescription)
                              } else {
                                  print("Called javascript:EPSChart()")
                              }
            
        })
        }

    }
}

struct WebView : UIViewRepresentable {

    var htmlfilename:String
    var ticker:String
    var change:Double
    var timestamp:Int
    
    init(htmlfilename:String, ticker:String, change:Double=0.0, timestamp:Int=0){
        self.htmlfilename = htmlfilename
        self.ticker = ticker
        self.change = change
        self.timestamp = timestamp
    }
    
    
    
   func makeUIView(context: Context) -> WKWebView {
       let webview = WKWebView()
       webview.navigationDelegate = context.coordinator
       return webview
   }

    func makeCoordinator() -> Coordinator {
        Coordinator(view: self)
    }

   func updateUIView(_ uiView: UIViewType, context: Context) {
       uiView.load(htmlfilename)
//       uiView.loadFileURL(url, allowingReadAccessTo: url)
   }
}




extension WKWebView{
    func load(_ htmlfilename:String){
        guard !htmlfilename.isEmpty else{
            return print("error ")
        }

        guard let filepath = Bundle.main.path(forResource: htmlfilename, ofType: "html") else{
            return  print("Error ")
        }

        let url = URL(fileURLWithPath: filepath)
        do{
            let htmlString = try String(contentsOfFile: filepath, encoding: .utf8)

            loadHTMLString(htmlString, baseURL: url)
        }
        catch{
            print("error")
        }
    }
}
