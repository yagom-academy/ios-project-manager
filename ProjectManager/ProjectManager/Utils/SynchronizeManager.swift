//
//  SyncManager.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/21.
//

import Foundation
import Firebase

struct SynchronizeManager {
    
    let realmManager: RealmManager
    private let reference = Database.database().reference()
    
    func synchronizeDatabase(completion: @escaping (Result<Void, Error>) -> Void) {
        var realmData = [Task]()
        var firebaseData = [Task]()
                
        DispatchQueue.main.async {
            realmData = realmManager.fetchAllTasks()
        }
        
        reference.observeSingleEvent(of: .value) { snapshot in
            let snapData = snapshot.value as? [String: [String: Any]] ?? [:]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
                let decoder = JSONDecoder()
                firebaseData = try decoder.decode([Task].self, from: data)
                
                let dataOutOfSync = self.dataOutOfSync(from: firebaseData, with: realmData)
                updateRemoteDatabase(localData: realmData)
                removeFromRemoteDatabase(tasks: dataOutOfSync)
                
                completion(.success(()))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
    
    private func updateRemoteDatabase(localData: [Task]) {
        localData.forEach {
            let taskForUpdate = Task(
                title: $0.title,
                body: $0.body,
                date: $0.date,
                taskType: $0.taskType,
                id: $0.id
            ).toDictionary()
            
            self.reference.child($0.id).setValue(taskForUpdate)
        }
    }
    
    private func removeFromRemoteDatabase(tasks: [Task]) {
        tasks.forEach {
            self.reference.child($0.id).removeValue()
        }
    }
    
    private func dataOutOfSync(from firebaseData: [Task], with realmData: [Task]) -> [Task] {
        var ids = [String]()
        realmData.forEach {
            ids.append($0.id)
        }
        
        let data = firebaseData.filter {
            !ids.contains($0.id)
        }
        return data
    }
}
