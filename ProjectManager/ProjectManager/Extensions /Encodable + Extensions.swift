import Foundation

enum ConvertError: Error {
    
    case missEncoding
    case missDecoding
}

extension Encodable {
    
    func toJson(excluding keys: [String] = []) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any]
        else {
            throw ConvertError.missEncoding
        }
        
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
}

extension Project {
    
    static func convertDictionaryToInstance(attributes: [String: Any]) -> Listable? {
        
        guard let json = try? JSONSerialization.data(withJSONObject: attributes)
        else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let project = try? decoder.decode(Project.self, from: json)
        else {
            return nil
        }
        
        return project
    }
}

