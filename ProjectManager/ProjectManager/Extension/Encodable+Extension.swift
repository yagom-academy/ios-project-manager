//
//  Encodable+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 19/07/2022.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: object, options: []) else { return nil }
        guard let dictionary = jsonObject as? [String: Any] else { return nil }
        return dictionary
    }
}
