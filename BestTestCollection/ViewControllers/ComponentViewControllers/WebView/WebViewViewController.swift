//
//  WebViewViewController.swift
//  BestTestCollection
//
//  Created by Taesan Kim on 2021/03/23.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var btnLoadWebPage: UIButton!
    
    @IBOutlet weak var webViewContainerView: UIView!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        
        let configuration = WKWebViewConfiguration()
        
        let processPool = WKProcessPool() //WKWebView Cookie공유를 위한 부분
        configuration.processPool = processPool
        
        //Set UserAgent
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String{
            
            let baseUserAgent = configuration.applicationNameForUserAgent ?? ""
            configuration.applicationNameForUserAgent = "\(baseUserAgent) | BestTestCollection |  \(appVersion)"
        }
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: configuration)

        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self

        self.webViewContainerView.addSubview(webView)
    }
    
    func initView() {
        self.btnLoadWebPage.backgroundColor = baseColor
        self.btnLoadWebPage.tintColor = baseTextColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadWebPage(url: "https://www.whatsmyua.info")
    }
    
    //Load web page from URL
    func loadWebPage(url: String) {
        let reqeust = URLRequest(url: URL(string: url)!)
        self.webView.load(reqeust)
    }
    
    @IBAction func loadWebPageButtonPressed(_ sender: Any) {
        let urlString = self.tfAddress.text!
        
        loadWebPage(url: urlString)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        print("========================================================")
        print("WKNavigationDelegate didFail : urlString -\(webView.url?.absoluteString ?? "UNKOWN")")
        print("========================================================")
        
        //stop indigator
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("WKNavigationDelegate didFailProvisionalNavigation")
        print("reason = \(error)")
        
        //stop indigator
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            
            print("WKNavigationDelegate url error")
            decisionHandler(.cancel)
            return
        }
          
        //스킴 확인
    
        print("========================================================")
        print("decidePolicyFor = \(url)")
        print("========================================================")

        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        let urlString = webView.url?.absoluteString
        
        print("========================================================")
        print("WKNavigationDelegate didFinish : urlString -\(urlString)")
        print("========================================================")

        //stop indigator
    }
}
