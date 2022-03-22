//
//  Encodable+Extension.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/22.
//

import Foundation

extension Encodable {
    
    func jsonObjectToDictionary<T: Encodable>(of type: T) -> [String: Any] {
        guard let data = try? JSONEncoder().encode(type),
              let dict = try? JSONSerialization.jsonObject(
                with: data,
                options: []) as? [String: Any] else {
                    return [:]
                }
        return dict
    }
}
