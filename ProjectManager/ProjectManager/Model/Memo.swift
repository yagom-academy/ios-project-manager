//
//  TableItem.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit
import MobileCoreServices

final class Memo: NSObject {
    let title: String
    let content: String
    let date: Double
    
    init(
        title: String,
        content: String,
        date: Double
    ) {
        self.title = title
        self.content = content
        self.date = date
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
