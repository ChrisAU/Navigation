//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

public final class Navigation<Value> {
    enum Orientation: String, Codable, NavigationPath {
        case horizontal = ">"
        case vertical = "^"

        var path: String { rawValue }
    }

    struct Item {
        let orientation: Orientation
        let value: Value
    }

    let items: LinkedList<Item>

    init(items: LinkedList<Item> = .init()) {
        self.items = items
    }

    public func push(_ value: Value) {
        items.append(Item(orientation: .horizontal, value: value))
    }

    public func pop() {
        if items.last?.value.orientation == .horizontal {
            items.dropLast()
        }
    }

    public func present(_ value: Value) {
        if items.first == nil {
            return
        }
        items.append(Item(orientation: .vertical, value: value))
    }

    public func dismiss() {
        let modal = items.last(where: { $0?.value.orientation == .vertical })
        items.setTail(modal?.previous)
    }
}
