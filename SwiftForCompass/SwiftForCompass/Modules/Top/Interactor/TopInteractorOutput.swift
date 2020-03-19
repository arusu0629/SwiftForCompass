//
//  TopTopInteractorOutput.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import Foundation

protocol TopInteractorOutput: class {
    func onSuccessedFetchEvent(events: [Event], availableEventCount: Int)
    func onSuccessedFetchLatestEvent(events: [Event], availableEventCount: Int)
    func onSuccessedRefreshEvent(events: [Event], availableEventCount: Int)
    func onFailedFetchEvent(errorMessage: String)
    func onFailedFetchLatestEvent(errorMessage: String)
    func onFailedRefreshEvent(errorMessage: String)
}
