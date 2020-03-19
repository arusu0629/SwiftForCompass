//
//  WebWebRouter.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class WebRouter: WebRouterInput {
    static func createModule() -> WebViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WebViewController") as! WebViewController
    }
}
