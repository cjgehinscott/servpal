//
//  WebAppVC.swift
//  Servpal
//
//  Created by CJ Gehin-Scott on 12/16/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebAppVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: ServPalApiManager.kBaseUrl)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        webView.reload()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.setForegroundColor(UIColor.primary)
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }

}
