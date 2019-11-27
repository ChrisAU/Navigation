//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

extension Node: NavigationPath where Value: NavigationPath {
    var path: String {
        var buffer = [value.path]
        var current = next
        while let x = current {
            buffer.append(x.value.path)
            current = current?.next
        }
        return buffer.joined(separator: ".")
    }
}
