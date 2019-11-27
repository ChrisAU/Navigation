//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

extension Navigation: Decodable where Value: Decodable {
    convenience public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.init(items: try container.decode(LinkedList<Item>.self))
    }
}

extension Navigation: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(items)
    }
}
