//
//  NetworkManager.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/19.
//

import FirebaseDatabase
import RxSwift

enum NetworkError: Error {
    case loadFailure
}

final class NetworkManager {
    private let projectsReference = Database.database().reference(withPath: "user")
}

extension NetworkManager {
    func read() -> Observable<[ProjectDTO]> {
        
        return Observable.create { emitter in
            
            Database.database().reference(withPath: "user").getData { error, snapshot in
                guard error == nil else {
                    return
                }

                guard let value = snapshot?.value as? [String: Any],
                      let data = try? JSONSerialization.data(withJSONObject: value.map { $1 }),
                      let projects = try? JSONDecoder().decode([ProjectDTO].self, from: data) else {
                    return
                }
                
                emitter.onNext(projects)
            }
            
            return Disposables.create()
        }
    }
    
    func update(projects: [ProjectDTO]) {
        var dic: [String: [String: String]] = [:]
        
        projects.forEach {
            dic[$0.id] = ["id": $0.id, "status": $0.status, "title": $0.title, "deadline": $0.deadline, "body": $0.body]
        }
        
        Database.database().reference().child("user").setValue(dic)
    }
}
