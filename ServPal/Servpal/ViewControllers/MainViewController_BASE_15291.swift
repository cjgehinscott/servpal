//
//  ViewController.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController, WKUIDelegate{

    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Servpal"
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.barTintColor = .primaryDark
        self.navigationController?.navigationBar.tintColor = .white
        webview.uiDelegate = self
        //webview?.load(URLRequest(url: URL(string: ServPalApiManager.kBaseUrl)!))
        UIApplication.shared.open(URL(string: ServPalApiManager.kBaseUrl)!, options: [:], completionHandler: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        if (webview?.canGoBack)! {
            webview?.goBack()
        }
    }
    
    @IBAction func refreshPage(_ sender: Any) {
        webview?.reload()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

