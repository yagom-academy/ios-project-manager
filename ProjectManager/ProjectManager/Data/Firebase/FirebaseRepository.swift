//
//  FirebaseRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/27.
//

import Foundation

class FirebaseRepository: ProjectRepository {
    private var firebase: FirebaseManager<ProjectModel>
    
    init() {
        firebase = FirebaseManager<ProjectModel>(rootChildID: "ProjectModel")
    }
    
    func create(data: ProjectModel) {
        do {
            try firebase.setValue(childId: data.id, model: data)
        } catch {
            print(error)
        }
    }
    
    func read(completionHandler: @escaping ([ProjectModel]) -> Void) {
        firebase.readAllValue { database in
            switch database {
            case .success(let data):
                completionHandler(data)
                
                return
            case .failure(let error):
                print(error)
                completionHandler([])
            }
        }
    }
    
    func update(id: String, data: ProjectModel) {
        do {
            try firebase.setValue(childId: id, model: data)
        } catch {
            print(error)
        }
    }
    
    func delete(id: String) {
        firebase.deleteValue(childId: id)
    }
}
