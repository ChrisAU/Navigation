//
//  NavigationCodableTests.swift
//  NavigationTests
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import XCTest
@testable import Navigation

class NavigationCodableTests: XCTestCase {
    var navigation: Navigation<MockValue>!

    override func setUp() {
        navigation = .init()
    }

    override func tearDown() {
        navigation = nil
    }

    func execute(_ events: [NavigationEvent], line: UInt = #line) {
        events.forEach { event in
            event.execute(on: navigation)
        }
        var encoded: Data?
        func encode() throws {
            encoded = try JSONEncoder().encode(navigation)
        }
        XCTAssertNoThrow(try encode())
        XCTAssertNotNil(encoded)

        var decoded: Navigation<MockValue>?
        func decode() throws {
            decoded = try JSONDecoder().decode(Navigation.self, from: encoded!)
        }

        XCTAssertNoThrow(try decode())
        XCTAssertNotNil(decoded)
        XCTAssertEqual(navigation.path, decoded?.path)
    }

    func testPushPush() {
        execute(
            [
                .push(.search(.init())),
                .push(.login(.init()))
            ]
        )
    }

    func testPushPresent() {
        execute(
            [
                .push(.search(.init())),
                .present(.login(.init()))
            ]
        )
    }
}
