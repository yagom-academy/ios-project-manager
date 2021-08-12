//
//  Task.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/07/31.
//

import Foundation
import MobileCoreServices

final class Task: NSObject {
    let title: String
    let context: String
    let deadline: Date
    var classification: String

    init(title: String, context: String, deadline: Date, classification: String) {
        self.title = title
        self.context = context
        self.deadline = deadline
        self.classification = classification
    }
}

extension Task: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }

    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
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

extension Task: NSItemProviderReading, Codable {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        do {
            let subject = try JSONDecoder().decode(Task.self, from: data)
            return subject
        } catch {
            fatalError()
        }
    }
}
