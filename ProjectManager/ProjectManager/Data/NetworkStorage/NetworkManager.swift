//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import FirebaseDatabase

enum NetworkError: Error {
    case loadFailure
}

final class NetworkManager {
    private let projectsReference = Database.database().reference(withPath: "user")
}

extension NetworkManager {
    func create(project: ProjectDTO) {
        let projectItem = projectsReference.child(project.id.uuidString)
        let values: [String: Any] = [
            "status": project.status,
            "title": project.title,
            "deadline": project.deadline,
            "body": project.body
        ]
        
        projectItem.setValue(values)
    }
    
    func read(completion: @escaping (Result<[ProjectDTO], NetworkError>) -> Void) {
        projectsReference.getData(completion: { error, snapshot in
            guard error == nil,
                  let projects = snapshot?.value as? [ProjectDTO] else {
                completion(.failure(.loadFailure))
                return
            }
            
            completion(.success(projects))
        })
    }
    
    func read(
        id: UUID?,
        completion: @escaping (Result<ProjectDTO, NetworkError>) -> Void
    ) {
        guard let id = id?.uuidString else {
            return
        }
        
        projectsReference.child(id).getData(completion: { error, snapshot in
            guard error == nil else {
                completion(.failure(.loadFailure))
                return
            }
            
            guard let project = snapshot?.value as? ProjectDTO else {
                completion(.failure(.loadFailure))
                return
            }
            
            completion(.success(project))
        })
    }

    func update(projects: [ProjectDTO]) {
        projectsReference.updateChildValues(["user": projects])
    }

    func delete(projectContentID: UUID?) {
        guard let id = projectContentID?.uuidString else {
            return
        }

        projectsReference.child(id).removeValue()
    }
}
