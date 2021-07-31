//
//  Task.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/18.
//
import Foundation
import MobileCoreServices

class Task: NSObject, Codable {
    var title: String
    var detail: String
    var deadline: Double
    var status: String
    var id: String
    
    enum CodingKeys: String, CodingKey {
        case title 
        case detail = "description"
        case deadline = "date"
        case status
        case id
    }
    init(title: String, detail: String, deadline: Double, status: String, id: String) {
        self.title = title
        self.detail = detail
        self.deadline = deadline
        self.status = status
        self.id = id
    }
}

extension Task: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeUTF8PlainText as String]
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

extension Task: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeUTF8PlainText as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        
        let decoder = JSONDecoder()
        do {
            let task = try decoder.decode(Task.self, from: data)
            return task as! Self
        } catch {
            fatalError()
        }
    }
}
