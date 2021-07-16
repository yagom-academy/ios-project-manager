//
//  Task.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/07/01.
//

import UIKit
import MobileCoreServices

final class Task: NSObject, NSItemProviderReading, NSItemProviderWriting, Codable {
    
    let id: String? // optional or decodable
    var title: String
    var content: String
    var deadlineDate: Date
    var classification: String //progress
    let isDeleted: Bool // deprecated
    // status: String created, updated, deleted -> enum
    // index: Int
    init (id: String, title: String, content: String, deadlineDate: Date, classification: String) {
        self.id = id
        self.title = title
        self.content = content
        self.deadlineDate = deadlineDate
        self.classification = classification
        self.isDeleted = false
    }
    
    //MARK: - NSItemProviderWriting
    
    static var writableTypeIdentifiersForItemProvider = [kUTTypeUTF8PlainText as String]
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        if typeIdentifier == kUTTypeUTF8PlainText as String {
            guard let encodedTask = try? JSONEncoder().encode(self) else {
                return nil
            }
            completionHandler(encodedTask, nil)
        } else {
            completionHandler(nil, DragAndDropError.invalidTypeIdentifier)
        }
        return nil
    }
    
    //MARK: - NSItemProviderReading
    
    static var readableTypeIdentifiersForItemProvider = [kUTTypeUTF8PlainText as String]
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        if typeIdentifier == kUTTypeUTF8PlainText as String {
            guard let task = try? JSONDecoder().decode(Task.self, from: data) else { throw DragAndDropError.jsonParsingError }
            return task
        } else {
            throw DragAndDropError.invalidTypeIdentifier
        }
    }
}
