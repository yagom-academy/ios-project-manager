//
//  SyncManager.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/21.
//

import Foundation
import Firebase

struct SynchronizeManager {
    
    private let realmManager = RealmManager()
    private let reference = Database.database().reference()
    
    func synchronizeDatabase() {
        let realmData = realmManager.fetchAllTasks()
        var firebaseData = [Task]()
        
        reference.observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String: [String: Any]] else { return }
            guard let data = try? JSONSerialization.data(withJSONObject: Array(snapData.values), options: []) else { return }
            
            do {
                let decoder = JSONDecoder()
                firebaseData = try decoder.decode([Task].self, from: data)
                let dataOutOfSync = self.dataOutOfSync(from: firebaseData, with: realmData)
                updateRemoteDatabase(localData: realmData)
                removeFromRemoteDatabase(tasks: dataOutOfSync)
            } catch let error {
                print("\(error.localizedDescription)")
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
