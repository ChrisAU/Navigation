//
//  NavigationEvent.swift
//  NavigationTests
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation
@testable import Navigation

enum NavigationEvent {
    case push(MockValue)
    case pop
    case present(MockValue)
    case dismiss

    func execute(on navigation: Navigation<MockValue>) {
        switch self {
        case .dismiss: navigation.dismiss()
        case .pop: navigation.pop()
        case .push(let value): navigation.push(value)
        case .present(let value): navigation.present(value)
        }
    }
}
