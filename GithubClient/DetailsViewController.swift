//
//  DetailsViewController.swift
//  GithubClient
//
//  Created by Roman Slezenko on 4/12/19.
//  Copyright © 2019 Roman Slezenko. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {
   
    var link = String()
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load.style = UIActivityIndicatorView.Style.whiteLarge
        load.color = .black
        load.startAnimating()
        
        let url = NSURL (string: link)
        let requestObj = NSURLRequest(url: url! as URL)
        webview.navigationDelegate = self
        webview.load(requestObj as URLRequest)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
        load.isHidden = true
    }
    



}
