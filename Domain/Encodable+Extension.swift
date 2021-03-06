//
//  EncodableExtension.swift
//  Domain
//
//  Created by Hoff Henry Pereira da Silva on 02/08/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Foundation

extension Encodable {
    public func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

extension Data {
    public func toModel<Element: Decodable>() -> Element? {
        try? JSONDecoder().decode(Element.self, from: self)
    }
    
    public func toJSON() -> [String:Any]? {
        try? JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String:Any]
    }
}

