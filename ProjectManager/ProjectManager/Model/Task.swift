//
//  Task.swift
//  ProjectManager
//
//  Created by steven on 7/22/21.
//

import Foundation
import MobileCoreServices

final class Task: NSObject {
    var title: String
    var content: String
    var deadLine: String
    var state: String
    
    init(title: String, content: String, deadLine: String, state: String) {
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.state = state
    }
}

extension Task: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String,
                  forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
}

extension Task: Codable, NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        do {
            let task = try JSONDecoder().decode(Task.self, from: data)
            return task
        } catch {
            fatalError()
        }
    }
}
