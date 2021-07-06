//
//  TableItem.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import UIKit
import MobileCoreServices

// TODO: - item 구성이름(title,date,summary) 서버side 이름과 통일시켜야 함
final class TableItem: NSObject {
    let title: String
    let summary: String
    let date: Double
    
    override init() {
        title = ""
        summary = ""
        date = 0.0
        
        super.init()
    }
    
    init(title: String,
         summary: String,
         date: Double) {
        self.title = title
        self.summary = summary
        self.date = date
    }
}

extension TableItem: NSItemProviderWriting {
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

extension TableItem: Codable, NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [String(kUTTypeData)]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        do {
            let subject = try JSONDecoder().decode(TableItem.self, from: data)
            return subject as! Self
        } catch {
            fatalError()
        }
    }
}
