//
//  TableItem.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit
import MobileCoreServices

final class Memo: NSObject {
    let id: String
    let title: String
    let content: String
    let dueDate: String
    let memoType: String
    
    init(
        id: String,
        title: String,
        content: String,
        dueDate: String,
        memoType: String
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.dueDate = dueDate
        self.memoType = memoType
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, title, content
        case dueDate = "due_date"
        case memoType = "memo_type"
    }
}

extension Memo: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    func loadData(
        withTypeIdentifier typeIdentifier: String,
        forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void
    ) -> Progress? {
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

extension Memo: Codable, NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(
        withItemProviderData data: Data,
        typeIdentifier: String
    ) throws -> Self {
        do {
            let subject = try JSONDecoder().decode(
                Memo.self,
                from: data
            )
            return subject as! Self
        } catch {
            fatalError()
        }
    }
}
