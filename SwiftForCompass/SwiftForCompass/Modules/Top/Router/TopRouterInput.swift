//
//  TopTopRouterInput.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import Foundation
import UIKit

protocol TopRouterInput {
    func pushToWebViewController(navigationController: UINavigationController, requestUrl: String)
}
