//
//  UINavigationController+Navigation.swift
//  Navigation
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import UIKit
import ObjectiveC

extension UINavigationController {
    var navigationPath: String {
        var path = viewControllers.map { $0.navigationPathComponent }.joined(separator: ".")
        if let modalPath = (presentedViewController as? UINavigationController)?.navigationPath {
            path = "\(path).\(modalPath)"
        }
        return path
    }

    public func update<T: NavigationPath>(navigation: Navigation<T>, resolver: NavigationPathResolver) {
        if let first = navigation.items.first {
            push(node: first, resolver: resolver)
        } else {
            setViewControllers([], animated: false)
        }
    }

    func modal<T: NavigationPath>(node: Node<Navigation<T>.Item>, resolver: NavigationPathResolver) {
        if let resolved = resolver.resolve(value: node.value) {
            let navigationController = UINavigationController(rootViewController: resolved)
            resolved.navigationPathComponent = node.value.path
            present(navigationController, animated: false, completion: nil)
            if let modal = node.next {
                navigationController.push(node: modal, resolver: resolver)
            }
        }
    }

    func push<T: NavigationPath>(node: Node<Navigation<T>.Item>, resolver: NavigationPathResolver) {
        var depth: Int = 0
        var next: Node<Navigation<T>.Item>? = node
        var subset = viewControllers
        while let current = next {
            guard current.path.starts(with: ">") else {
                setViewControllers(subset, animated: false)
                if current.path.starts(with: "^") {
                    modal(node: current, resolver: resolver)
                }
                return
            }
            if subset.indices.contains(depth) {
                if subset[depth].navigationPathComponent != current.path {
                    subset = Array(subset[0..<depth])
                    if let resolved = resolver.resolve(value: current.value.value) {
                        resolved.navigationPathComponent = current.value.path
                        subset.append(resolved)
                    }
                }
            } else {
                if let resolved = resolver.resolve(value: current.value.value) {
                    resolved.navigationPathComponent = current.value.path
                    subset.append(resolved)
                }
            }
            next = current.next
            depth += 1
        }
        setViewControllers(subset, animated: false)
    }
}

extension UIViewController {
    private enum Associated {
        static var navigationPathComponentHandle: UInt8 = 0
    }

    var navigationPathComponent: String {
        get {
            return objc_getAssociatedObject(self, &Associated.navigationPathComponentHandle) as! String
        }
        set {
            objc_setAssociatedObject(self, &Associated.navigationPathComponentHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
