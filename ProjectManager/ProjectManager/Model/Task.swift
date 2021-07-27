//
//  Task.swift
//  ProjectManager
//
//  Created by 배은서 on 2021/07/22.
//

import Foundation
import MobileCoreServices

final class Task: NSObject, Codable {
    let id: String?
    let title: String
    let content: String
    let deadLineDate: Date
    let classification: String
    var formattedDeadLineDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ko_kr")
        return dateFormatter.string(from: self.deadLineDate)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, content, classification
        case deadLineDate = "deadline_date"
    }
}

extension Task: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePlainText as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        do {
            let data = try JSONEncoder().encode(self)
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        
        return nil
    }
}

extension Task: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePlainText as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        guard let decodeData = try? JSONDecoder().decode(self, from: data)
        else { throw TaskError.invalidData }
        
        return decodeData
    }
}
