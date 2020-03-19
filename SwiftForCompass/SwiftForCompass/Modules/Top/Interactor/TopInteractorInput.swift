//
//  TopTopInteractorInput.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import Foundation

protocol TopInteractorInput {
    func fetchEvent(_ searchWords: String, startIndex: Int, count: Int)
    func fetchLatestEvent(_ searchWords: String)
    func refreshEvent(_ searchWords: String)
}
