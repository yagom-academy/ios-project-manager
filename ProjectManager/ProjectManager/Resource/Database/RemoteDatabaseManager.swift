//
//  RemoteDatabaseManager.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/07.
//

import Firebase

final class RemoteDatabaseManager {
    static let shared = RemoteDatabaseManager()

    private let reference: DatabaseReference

    private init() {
        self.reference = Database.database().reference()
    }

    func create(data: ProjectUnit) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        let jsonData = try? encoder.encode(data)

        if let jsonData = jsonData,
           let jsonString = String(data: jsonData, encoding: .utf8),
           let dicData = try? JSONSerialization.jsonObject(with: Data(jsonString.utf8), options: []) as? [String: Any] {
            reference.child("ProjectList").child("\(data.id)").setValue(jsonString)
        }
    }

    func fetch() -> [String: ProjectUnit] {
        var result: [String: ProjectUnit] = [:]
        let decoder = JSONDecoder()

        reference.child("ProjectList").getData { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            let sample: [String: Any] = snapshot?.value as? [String: Any] ?? ["": ""]
            let data = try? JSONSerialization.data(withJSONObject: sample)
            if let data = data,
               let finalSampleData = try? decoder.decode([String: ProjectUnit].self, from: data) {
                result = finalSampleData
            }
        }

        return result
    }

    func update(data: ProjectUnit) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys, .prettyPrinted]

        let jsonData = try? encoder.encode(data)

        if let jsonData = jsonData,
           let jsonString = String(data: jsonData, encoding: .utf8),
           let dicData = try? JSONSerialization.jsonObject(with: Data(jsonString.utf8), options: []) as? [String: Any] {
            reference.child("ProjectList").child("\(data.id)").setValue(jsonString)
        }
    }

    func delete(id: UUID) throws {
        reference.child("ProjectList").child("\(id)").setValue(nil)
    }
}
