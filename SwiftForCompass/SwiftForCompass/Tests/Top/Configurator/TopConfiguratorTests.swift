//
//  TopTopConfiguratorTests.swift
//  SwiftForCompass
//
//  Created by Toru_Nakandakari on 16/03/2020.
//  Copyright © 2020 t-nakandakari. All rights reserved.
//

import XCTest

class TopModuleConfiguratorTests: XCTestCase {

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
        let viewController = TopViewControllerMock()
        let configurator = TopModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "TopViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TopPresenter, "output is not TopPresenter")

        let presenter: TopPresenter = viewController.output as! TopPresenter
        XCTAssertNotNil(presenter.view, "view in TopPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TopPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TopRouter, "router is not TopRouter")

        let interactor: TopInteractor = presenter.interactor as! TopInteractor
        XCTAssertNotNil(interactor.output, "output in TopInteractor is nil after configuration")
    }

    class TopViewControllerMock: TopViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
