//
//  WebWebViewController.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WebViewInput {

    private let webView = WKWebView()
    var requestUrl = ""
    var output: WebViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        
        webView.frame = view.frame
        view.addSubview(webView)
        
        let url = URL(string: requestUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    // MARK: WebViewInput
    func setupInitialState() {
    }
}
