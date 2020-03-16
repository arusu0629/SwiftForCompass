//
//  TopTopInitializer.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import UIKit

class TopModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var topViewController: TopViewController!

    override func awakeFromNib() {
        let configurator = TopModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: topViewController)
    }

}
