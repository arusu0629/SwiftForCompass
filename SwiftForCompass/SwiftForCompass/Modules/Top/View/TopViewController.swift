//
//  TopTopViewController.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, TopViewInput {

    var output: TopViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: TopViewInput
    func setupInitialState() {
    }
}
