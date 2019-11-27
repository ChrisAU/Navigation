//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import XCTest
@testable import Navigation

class NavigationTests: XCTestCase {
    var navigation: Navigation<MockValue>!

    override func setUp() {
        navigation = .init()
    }

    override func tearDown() {
        navigation = nil
    }

    func execute(_ mapping: (NavigationEvent, String)..., line: UInt = #line) {
        mapping.forEach { event, output in
            event.execute(on: navigation)
            XCTAssertEqual(navigation.path, output, line: line)
        }
    }

    func testPushPushPopPop() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.push(.login(.init())), ">Search.>Login"),
            (.pop, ">Search"),
            (.pop, "Empty")
        )
    }

    func testPushPresentDismiss() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.present(.login(.init())), ">Search.^Login"),
            (.dismiss, ">Search")
        )
    }

    func testPushPresentPushPop() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.present(.login(.init())), ">Search.^Login"),
            (.push(.settings(.init())), ">Search.^Login.>Settings"),
            (.pop, ">Search.^Login")
        )
    }

    func testPushPresentPushDismiss() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.present(.login(.init())), ">Search.^Login"),
            (.push(.settings(.init())), ">Search.^Login.>Settings"),
            (.dismiss, ">Search")
        )
    }

    func testPushPresentPop() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.present(.login(.init())), ">Search.^Login"),
            (.pop, ">Search.^Login")
        )
    }

    func testPresent() {
        execute(
            (.present(.search(.init())), "Empty")
        )
    }

    func testPushPresentPresentPresentThenDismissAll() {
        execute(
            (.push(.search(.init())), ">Search"),
            (.present(.login(.init())), ">Search.^Login"),
            (.present(.settings(.init())), ">Search.^Login.^Settings"),
            (.present(.area(.init())), ">Search.^Login.^Settings.^Area"),
            (.dismiss, ">Search.^Login.^Settings"),
            (.dismiss, ">Search.^Login"),
            (.dismiss, ">Search")
        )
    }
}
