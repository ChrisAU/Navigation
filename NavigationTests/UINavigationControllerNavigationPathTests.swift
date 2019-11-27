//
//  NavigationPathTests.swift
//  NavigationTests
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import UIKit
import XCTest
@testable import Navigation

class NavigationPathTests: XCTestCase {
    var navigationController: UINavigationController!
    var navigation: Navigation<MockValue>!
    var resolver: MockNavigationPathResolver!

    override func setUp() {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("Unable to find window")
        }
        resolver = MockNavigationPathResolver()
        navigation = Navigation<MockValue>()
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        RunLoop.current.run(until: Date())
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        resolver = nil
        navigation = nil
    }

    func expect(_ output: String, for events: [NavigationEvent], line: UInt = #line) {
        events.forEach { event in
            event.execute(on: navigation)
        }
        navigationController.update(navigation: navigation, resolver: resolver)
        XCTAssertEqual(navigationController.navigationPath, output, line: line)
    }

    func testPush() {
        expect(">Search", for: [.push(.search(.init()))])
    }

    func testPushMultiple() {
        expect(">Search.>Area.>Department.>Level", for:
            [
                .push(.search(.init())),
                .push(.area(.init())),
                .push(.department(.init())),
                .push(.level(.init()))
            ]
        )
    }

    func testPushPresentMultiplePush() {
        expect(">Search.^Area.^Department.>Level", for:
            [
                .push(.search(.init())),
                .present(.area(.init())),
                .present(.department(.init())),
                .push(.level(.init()))
            ]
        )
    }

    func testPushMultipleThenPop() {
        testPushMultiple()
        expect(">Search.>Area.>Department", for: [.pop])
    }

    func testPushMultipleThenPopMultipleThenPushMultiple() {
        testPushMultiple()
        expect(">Search.>Login.>Department", for:
            [
                .pop,
                .pop,
                .pop,
                .push(.login(.init())),
                .push(.department(.init()))
            ]
        )
    }
}

class MockNavigationPathResolver: NavigationPathResolver {
    func resolve(value: NavigationPath) -> UIViewController? {
        return UIViewController(nibName: nil, bundle: nil)
    }
}
