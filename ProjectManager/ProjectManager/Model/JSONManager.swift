//
//  JSONManager.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/28.
//

import Foundation

final class JSONManager {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var dictionaryEncoder: JSONEncoder {
        self.encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        return encoder
    }
    
    static let shared = JSONManager()
    
    func encodeToDictionary<T: Encodable>(data: T) -> [String: Any]? {
        guard let jsonData = self.encodeToData(data: data),
           let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            return nil
        }
        
        return dictionary
    }
    
    func decodeToArray<T: Decodable>(data: [String: Any]) -> [T]? {
        guard let fetchedData = try? JSONSerialization.data(withJSONObject: data),
              let dictionary = try? self.decoder.decode([String: T].self, from: fetchedData) else {
            return nil
        }
        
        return Array(dictionary.values)
    }
    
    private func encodeToData<T: Encodable>(data: T) -> Data? {
        return try? dictionaryEncoder.encode(data)
    }
}
