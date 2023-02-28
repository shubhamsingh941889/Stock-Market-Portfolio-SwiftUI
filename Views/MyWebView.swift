////
////  MyWebView.swift
////  StocksAppCS571
////
////  Created by Shubham Singh on 28/04/22.
////
//
//import SwiftUI
//import WebKit
//import Combine
//
//class WebViewData: ObservableObject {
//    @Published var parsedText: NSAttributedString? = nil
//
//    var functionCaller = PassthroughSubject<Void,Never>()
//
//    var isInit = false
//    var shouldUpdateView = true
//}
//
//struct WebView: UIViewRepresentable {
//    let text: String
//
//    let htmlfilename:String
////    private let webView = WKWebView()
//
//    @StateObject var data: WebViewData
//
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webview = WKWebView()
//        webview.navigationDelegate = context.coordinator
//        return webview
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        guard data.shouldUpdateView else {
//            data.shouldUpdateView = false
//            return
//        }
//
//        context.coordinator.tieFunctionCaller(data: data)
//        context.coordinator.webView = uiView
//
////        uiView.evaluateJavaScript("newvalueGotFromIOS('\(self.text)');")
//
//        uiView.load(htmlfilename)
//
//
//    }
//
//    func makeCoordinator() -> WebViewCoordinator {
//        return WebViewCoordinator(view: self)
//    }
//}
//
//class WebViewCoordinator: NSObject, WKNavigationDelegate {
//    var parent: WebView
//    var webView: WKWebView? = nil
//
//    private var cancellable : AnyCancellable?
//
//    init(view: WebView) {
//        self.parent = view
//        super.init()
//    }
//
//    func tieFunctionCaller(data: WebViewData) {
//        let _ = print("ff",self.parent.text)
////        let temp = "aa"
//        cancellable = data.functionCaller.sink(receiveValue: { _ in
//            self.webView?.evaluateJavaScript("newvalueGotFromIOS('\(self.parent.text)');")
//        })
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        DispatchQueue.main.async {
//            if !self.parent.data.isInit {
//                self.parent.data.isInit = true
//                // useless text parsing here...
//            }
//        }
//    }
//}
//
//
//struct ReadingView: View {
//    @ObservedObject var webViewData = WebViewData()
//    var text : String
//
//    init(text: String?) {
//        self.text = text ?? "Sorry, this reading is empty"
//
//    }
//
//    var body: some View {
//        VStack {
//
//
//            WebView(text: "text", htmlfilename: "page2", data: webViewData)
//
//            Button("Call javascript") {
//                webViewData.functionCaller.send()
//            }
//        }
//
//    }
//}
//
//struct MyWebView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct MyWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReadingView(text: "nice")
//    }
//}
//
//
////struct WebView: UIViewRepresentable{
////    let htmlfilename:String
////
////    private let webView = WKWebView()
////
////    func makeUIView(context: Context) -> some View {
////
////        return webView
////    }
////
////    func makeCoordinator() -> Coordinator {
////            Coordinator()
////        }
////
////
////    func updateUIView(_ uiView: UIViewType, context: Context) {
////        webView.load(htmlfilename)
//////        let value = "heee"
//////        let javascriptFunction = "valueGotFromIOS()"
//////        let _ = print("js",javascriptFunction)
//////        self.webView.evaluateJavaScript("newvalueGotFromIOS();") { (response, error) in
//////              if let error = error {
//////                  print("Error calling javascript:valueGotFromIOS()")
//////                  print(error.localizedDescription)
//////              } else {
//////                  print("Called javascript:valueGotFromIOS()")
//////              }
//////          }
////    }
////}
//
////extension WKWebView{
////    func load(_ htmlfilename:String){
////        guard !htmlfilename.isEmpty else{
////            return print("error ")
////        }
////
////        guard let filepath = Bundle.main.path(forResource: htmlfilename, ofType: "html") else{
////            return  print("Error ")
////        }
////
////        let url = URL(fileURLWithPath: filepath)
////        do{
////            let htmlString = try String(contentsOfFile: filepath, encoding: .utf8)
////
////            loadHTMLString(htmlString, baseURL: url)
////        }
////        catch{
////            print("error")
////        }
////    }
////}
//
////struct WebView: UIViewRepresentable {
////    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
////        var webView: WKWebView?
////
////        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////            self.webView = webView
////        }
////
////        // receive message from wkwebview
////        func userContentController(
////            _ userContentController: WKUserContentController,
////            didReceive message: WKScriptMessage
////        ) {
////            print(message.body)
//////            let date = Date()
////
////                self.messageToWebview(msg: "hello, I got your messsage:")
////
////        }
////
////        func messageToWebview(msg: String) {
////            let javascriptFunction = "valueGotFromIOS(\(msg));"
////            self.webView?.evaluateJavaScript(javascriptFunction) { (response, error) in
////                  if let error = error {
////                      print("Error calling javascript:valueGotFromIOS()")
////                      print(error.localizedDescription)
////                  } else {
////                      print("Called javascript:valueGotFromIOS()")
////                  }
////              }
////
////
//////            self.webView?.evaluateJavaScript("webkit.messageHandlers.bridge.onMessage('\(msg)')")
////        }
////    }
////
////    func makeCoordinator() -> Coordinator {
////        return Coordinator()
////    }
////
////    func makeUIView(context: Context) -> WKWebView {
////        let coordinator = makeCoordinator()
////        let userContentController = WKUserContentController()
////        userContentController.add(coordinator, name: "bridge")
////
////        let configuration = WKWebViewConfiguration()
////        configuration.userContentController = userContentController
////
////        let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
////        _wkwebview.navigationDelegate = coordinator
////
////        return _wkwebview
////    }
////
////    func updateUIView(_ webView: WKWebView, context: Context) {
////        guard let path: String = Bundle.main.path(forResource: "page2", ofType: "html") else { return }
////        let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
////        webView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
////    }
////}
