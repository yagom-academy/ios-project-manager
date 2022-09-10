//
//  JSONDecoder + Extentsion.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import Foundation

// MARK: - Extentions

extension JSONDecoder {
    static func decodedJson<T: Decodable>(jsonName: String) -> T? {
        let decoder = JSONDecoder()
        guard let fileLocation = Bundle.main.url(forResource: jsonName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let sampleDiary = try decoder.decode(T.self, from: data)
            return sampleDiary
        } catch {
            print(error)
            return nil
        }
    }
}
