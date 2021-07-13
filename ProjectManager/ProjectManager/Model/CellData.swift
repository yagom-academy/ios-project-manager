//
//  CellData.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/07.
//

import Foundation
import MobileCoreServices

final class CellData: NSObject, Codable, NSItemProviderWriting, NSItemProviderReading {
    
    var title: String
    var body: String
    var deadline: Double
    var deadlineIsExpired: Bool
    var superViewType: TableViewType
    var sourceTableViewIndexPath: IndexPath?
    
    init(title: String, body: String, deadline: Double, deadlineIsExpired: Bool = false, superViewType: TableViewType) {
        self.title = title
        self.body = body
        self.deadline = deadline
        self.deadlineIsExpired = deadlineIsExpired
        self.superViewType = superViewType
    }
    
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> CellData {
        let decoder = JSONDecoder()
        do {
            let cellData = try decoder.decode(CellData.self, from: data)
            return cellData
        } catch {
            fatalError()
        }
    }
    
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
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
