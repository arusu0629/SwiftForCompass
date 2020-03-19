//
//  TopTopRouter.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//
import UIKit

class TopRouter: TopRouterInput {
    func pushToWebViewController(navigationController: UINavigationController, requestUrl: String) {
        let webViewController = WebRouter.createModule()
        webViewController.requestUrl = requestUrl
        navigationController.pushViewController(webViewController, animated: true)
    }
}
