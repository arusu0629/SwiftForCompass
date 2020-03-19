//
//  WebWebInitializer.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class WebModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var webViewController: WebViewController!

    override func awakeFromNib() {
        let configurator = WebModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: webViewController)
    }

}
