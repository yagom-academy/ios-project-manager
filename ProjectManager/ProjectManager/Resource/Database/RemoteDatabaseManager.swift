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

    func fetch(completion: @escaping ((Result<[ProjectUnit], JSONError>) -> Void)) {
        reference.child("ProjectList").queryOrderedByKey().getData { error, snapshot in
            guard error == nil else {
                completion(.failure(.defaultError))
                return
            }
            
            guard let fetchedData: [String: Any] = snapshot?.value as? [String: Any],
                  let decodedData: [ProjectUnit] = JSONManager.shared.decodeToArray(data: fetchedData) else {
                completion(.failure(.emptyError))
                return
            }
            
            completion(.success(decodedData))
        }
    }

    func delete(id: UUID) throws {
        reference.child("ProjectList").child("\(id)").setValue(nil)
    }
}
