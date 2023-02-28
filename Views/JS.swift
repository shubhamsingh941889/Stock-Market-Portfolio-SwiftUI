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
        let _ = print("web view",self.parent.ticker)
        if parent.htmlfilename=="daily"{
        webView.evaluateJavaScript("DailyCharts('\(self.parent.ticker)');", completionHandler:{
            (response, error) in
                              if let error = error {
                                  print("Error calling javascript:DailyCharts()")
                                  print(error.localizedDescription)
                              } else {
                                  print("Called javascript:DailyCharts()")
                              }
            
        })
        }
        if parent.htmlfilename=="historical"{
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
        if parent.htmlfilename=="insights"{
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
        if parent.htmlfilename=="eps"{
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

    let htmlfilename:String
    let ticker:String
    
    
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


struct JS: View {
    var body: some View {
    
        VStack {
            Text("hello")
            
//            WebView(htmlfilename: "page2", ticker: "AAPL")
        }
    }
}

struct JS_Previews: PreviewProvider {
    static var previews: some View {
        JS()
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
