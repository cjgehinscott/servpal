//
//  ViewController.swift
//  ServPal
//
//  Created by CJ Gehin-Scott on 11/7/17.
//  Copyright © 2017 ServPal. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController, WKUIDelegate {

    let basePath = "/professionals/find"

    private lazy var backButton: UIBarButtonItem = {
        let backButtonItem
                = UIBarButtonItem(title: "\u{25C0}\u{FE0E}", style: .plain, target: self, action: #selector(goBack))
        return backButtonItem
    }()

    private lazy var refreshButtonItem: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
    }()

    lazy var toolBar: UIToolbar = {
        let _toolbar = UIToolbar()
        return _toolbar
    }()

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let _webView         = WKWebView(frame: .zero, configuration: webConfiguration)
        _webView.uiDelegate = self
        self.view = _webView
        return _webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isToolbarHidden = false
        self.toolbarItems = [backButton, UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), refreshButtonItem]
        self.view.addSubview(toolBar)

        self.title = "Servpal"
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.barTintColor = .primaryDark
        self.navigationController?.navigationBar.tintColor = .white




        if var urlComps = URLComponents(string: ServPalApiManager.kBaseUrl) {
            let request = NSMutableURLRequest(url: urlComps.url!)
            webView.load(request as URLRequest)
        }
    }

    @objc
    func goBack() {
        webView.goBack()
    }

    @objc
    func refresh() {
        webView.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

