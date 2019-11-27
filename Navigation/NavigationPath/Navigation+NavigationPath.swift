//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

extension Navigation: NavigationPath where Value: NavigationPath {
    public var path: String {
        items.path
    }
}

extension Navigation.Item: NavigationPath where Value: NavigationPath {
    var path: String {
        "\(orientation.path)\(value.path)"
    }
}
