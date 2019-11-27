//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

enum NodeCodingKeys: String, CodingKey {
    case value
    case next
}

extension Node: Decodable where Value: Decodable {
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NodeCodingKeys.self)
        let value = try container.decode(Value.self, forKey: .value)
        self.init(value: value)
        if container.allKeys.contains(.next) {
            let innerDecoder = try container.superDecoder(forKey: .next)
            self.next = try Node(from: innerDecoder)
        }
    }
}

extension Node: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: NodeCodingKeys.self)
        try container.encode(value, forKey: .value)
        if let inner = next {
            let innerEncoder = container.superEncoder(forKey: .next)
            try inner.encode(to: innerEncoder)
        }
    }
}
