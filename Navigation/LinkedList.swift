//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

final class LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?

    var isEmpty: Bool {
        return head == nil
    }

    var first: Node<Value>? {
        return head
    }

    var last: Node<Value>? {
        return tail
    }

    func append(_ value: Value) {
        let newNode = Node(value: value)
        if let tailNode = tail {
            newNode.previous = tail
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }

    func dropLast() {
        if let previous = tail?.previous {
            setTail(previous)
        } else {
            tail = nil
            head = nil
        }
    }

    func setTail(_ node: Node<Value>?) {
        tail = node
        node?.next = nil
        if tail === head {
            head?.next = nil
        }
    }

    func first(where condition: @escaping (Node<Value>?) -> Bool) -> Node<Value>? {
        var candidate = head
        while let current = candidate, !condition(candidate) {
            candidate = current.next
        }
        return condition(candidate) ? candidate : nil
    }

    func last(where condition: @escaping (Node<Value>?) -> Bool) -> Node<Value>? {
        var candidate = tail
        while let current = candidate, !condition(candidate) {
            candidate = current.previous
        }
        return condition(candidate) ? candidate : nil
    }
}
