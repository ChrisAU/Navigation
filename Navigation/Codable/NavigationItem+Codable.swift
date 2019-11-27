//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 CJNevin. All rights reserved.
//

import Foundation

enum NavigationItemCodingKeys: String, CodingKey {
    case value, orientation
}

extension Navigation.Item: Decodable where Value: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NavigationItemCodingKeys.self)
        value = try container.decode(Value.self, forKey: .value)
        orientation = try container.decode(Navigation.Orientation.self, forKey: .orientation)
    }
}

extension Navigation.Item: Encodable where Value: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: NavigationItemCodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(orientation, forKey: .orientation)
    }
}
