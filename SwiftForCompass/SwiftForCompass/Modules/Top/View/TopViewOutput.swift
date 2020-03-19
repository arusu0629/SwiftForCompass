//
//  TopTopViewOutput.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

protocol TopViewOutput {

    /**
        @author Toru_Nakandakari
        Notify presenter that view is ready
    */
    func viewIsReady()
    func eventSearchTextFieldReturn(searchWord: String)
    func eventListTableViewPullToRefresh()
    func eventListTablelViewDidBottom()
    func onTappedRefreshButton()
}
