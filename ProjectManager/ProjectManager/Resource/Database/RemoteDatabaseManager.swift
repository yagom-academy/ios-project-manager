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

    func save(data: ProjectUnit) throws {
        reference.child("ProjectList").child("\(data.id)").setValue(data.convertToDictionary())
    }

    func fetch(completion: @escaping (([ProjectUnit]) -> Void)) {
        reference.child("ProjectList").getData { error, snapshot in
            guard error == nil else {
                return
            }
            
            guard let fetchedData: [String: Any] = snapshot?.value as? [String: Any],
                  let decodedData: [ProjectUnit] = JSONManager.shared.decodeToArray(data: fetchedData) else {
                return
            }
            
            completion(decodedData)
        }
    }

    func delete(id: UUID) throws {
        reference.child("ProjectList").child("\(id)").setValue(nil)
    }
}
