//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

final class Node<Value> {
    var value: Value
    var next: Node?
    weak var previous: Node?

    init(value: Value) {
        self.value = value
    }
}
