//
//  WebWebConfiguratorTests.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 19/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import XCTest

class WebModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = WebViewControllerMock()
        let configurator = WebModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "WebViewController is nil after configuration")
        XCTAssertTrue(viewController.output is WebPresenter, "output is not WebPresenter")

        let presenter: WebPresenter = viewController.output as! WebPresenter
        XCTAssertNotNil(presenter.view, "view in WebPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in WebPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is WebRouter, "router is not WebRouter")

        let interactor: WebInteractor = presenter.interactor as! WebInteractor
        XCTAssertNotNil(interactor.output, "output in WebInteractor is nil after configuration")
    }

    class WebViewControllerMock: WebViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
