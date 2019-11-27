//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

extension LinkedList: NavigationPath where Value: NavigationPath {
    var path: String {
        first?.path ?? "Empty"
    }
}
