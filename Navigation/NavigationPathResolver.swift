//
//  NavigationPathResolver.swift
//  Navigation
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import UIKit

public protocol NavigationPathResolver {
    func resolve(value: NavigationPath) -> UIViewController?
}
