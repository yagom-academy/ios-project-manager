//
//  Todo.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import Foundation
import MobileCoreServices

final class Todo: Codable {
    var title: String
    var descriptions: String?
    var deadLine: Date?
    
    init(title: String, descriptions: String?, deadLine: Date?) {
        self.title = title
        self.descriptions = descriptions
        self.deadLine = deadLine
    }
}

//extension Todo: NSItemProviderWriting {
//    static var writableTypeIdentifiersForItemProvider: [String] {
//        //We know that we want to represent our object as a data type, so we'll specify that
//        return [(kUTTypeData as String)]
//    }
//
//    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
//        let progress = Progress(totalUnitCount: 100)
//          do {
//            //Here the object is encoded to a JSON data object and sent to the completion handler
//            let data = try JSONEncoder().encode(self)
//            progress.completedUnitCount = 100
//            completionHandler(data, nil)
//          } catch {
//            completionHandler(nil, error)
//          }
//          return progress
//    }
//
//
//}
//
//extension Todo: NSItemProviderReading {
//    static var readableTypeIdentifiersForItemProvider: [String] {
//        return [(kUTTypeData as String)]
//    }
//
//    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Todo {
//        let decoder = JSONDecoder()
//          do {
//            //Here we decode the object back to it's class representation and return it
//            let todo = try decoder.decode(Todo.self, from: data)
//            return todo
//          } catch {
//            fatalError("error")
//          }
//    }
//
//
//}
