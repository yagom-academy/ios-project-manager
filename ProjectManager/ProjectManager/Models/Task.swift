//
//  TODOModel.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/06/30.
//

import UIKit
import MobileCoreServices

final class Task: NSObject, Codable {

    static var todoList: [Task] = []
    static var doingList: [Task] = []
    static var doneList: [Task] = []

    var title: String
    var date: Double
    var myDescription: String
    var status: String
    let identifier: String

    init(title: String, date: Double, myDescription: String, status: String, identifier: String){
        self.title = title
        self.date = date
        self.myDescription = myDescription
        self.status = status
        self.identifier = identifier
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
                completionHandler(nil, ConvertError.decodeError)
            }

          return progress
    }
}

extension Task: NSItemProviderReading {

    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypeUTF8PlainText as String]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Task {
        let decoder = JSONDecoder()

        do {
            let task = try decoder.decode(Task.self, from: data)
            return task
        } catch {
            throw ConvertError.encodeError
        }
    }
}
