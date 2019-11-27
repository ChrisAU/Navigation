//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

enum LinkedListCodingKeys: String, CodingKey {
    case head, tail
}

extension LinkedList: Decodable where Value: Decodable {
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LinkedListCodingKeys.self)
        self.init()
        self.head = try container.decode(Node<Value>?.self, forKey: .head)
        self.tail = try container.decode(Node<Value>?.self, forKey: .tail)
    }
}

extension LinkedList: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LinkedListCodingKeys.self)
        try container.encode(head, forKey: .head)
        try container.encode(tail, forKey: .tail)
    }
}
