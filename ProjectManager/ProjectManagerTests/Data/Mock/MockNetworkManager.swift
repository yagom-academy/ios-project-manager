//
//  MockNetworkManager.swift
//  ProjectManagerTests
//
//  Created by Tiana, mmim on 2022/07/29.
//

@testable import ProjectManager
import RxSwift

struct SampleData {
    static private let deadline = Calendar.current.date(byAdding: .day, value: 1, to: Date())!

    static let data = ProjectDTO(id: UUID().uuidString, status: ProjectStatus.todo.string, title: "title111", deadline: String(deadline.timeIntervalSince1970), body: "bodyttt")
}

struct MockFirebase {
    let error: Error?
    let defaultData = [SampleData.data]
    
    func getData(completion: @escaping (Error?, [ProjectDTO]?) -> Void) {
        completion(error, defaultData)
    }
    
    func setValue(_ dic: [String: [String: String]]) {
        
    }
}

final class MockNetworkManager: NetworkManagerProtocol {
    func read() -> Observable<[ProjectDTO]> {
        
        return Observable.create { emitter in
            MockFirebase(error: nil).getData { _, projects in
                emitter.onNext(projects!)
            }
            
            return Disposables.create()
        }
    }
    
    func update(projects: [ProjectDTO]) {
        var dic: [String: [String: String]] = [:]
        
        projects.forEach {
            dic[$0.id] = ["id": $0.id, "status": $0.status, "title": $0.title, "deadline": $0.deadline, "body": $0.body]
        }
        
        MockFirebase(error: nil).setValue(dic)
    }
}
