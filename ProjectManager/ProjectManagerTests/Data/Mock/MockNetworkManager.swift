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

    static let data = ProjectDTO(
        id: UUID().uuidString,
        status: ProjectStatus.todo.string,
        title: "title111",
        deadline: String(deadline.timeIntervalSince1970),
        body: "bodyttt"
    )
}

final class MockFirebase {
    let error: Error?
    private let defaultData = SampleData.data
    var database: [String: [String: String]] = [:]
    
    init(error: Error?) {
        self.error = error
        
        database[defaultData.id] = ["id": defaultData.id,
                                    "status": defaultData.status,
                                    "title": defaultData.title,
                                    "deadline": defaultData.deadline,
                                    "body": defaultData.body]
    }
    
    func getData(completion: @escaping (Error?, [String: [String: String]]?) -> Void) {
        completion(error, database)
    }
    
    func setValue(_ newData: [String: [String: String]]) {
        database = newData
    }
}

final class MockNetworkRepository {
    let database = MockFirebase(error: nil)
}

extension MockNetworkRepository: NetworkRepositoryProtocol {
    func update(repository: PersistentRepositoryProtocol) {
        let projects = repository.read().value.compactMap {
            parse(from: $0)
        }
        
        update(projects: projects)
    }
    
    func read(repository: PersistentRepositoryProtocol) -> Disposable {
        return read()
            .subscribe(onNext: {[weak self] data in
                self?.synchronize(with: data, to: repository)
            })
    }
}

extension MockNetworkRepository {
    private func read() -> Observable<[ProjectDTO]> {
        
        return Observable.create { [weak self] emitter in
            self?.database.getData { _, snapshot in
                guard let value = snapshot,
                      let data = try? JSONSerialization.data(withJSONObject: value.map { $1 }),
                      let projects = try? JSONDecoder().decode([ProjectDTO].self, from: data) else {
                    return
                }
                
                emitter.onNext(projects)
            }
            
            return Disposables.create()
        }
    }
    
    private func update(projects: [ProjectDTO]) {
        var newData: [String: [String: String]] = [:]
        
        projects.forEach {
            newData[$0.id] = [
                "id": $0.id,
                "status": $0.status,
                "title": $0.title,
                "deadline": $0.deadline,
                "body": $0.body
            ]
        }
        
        database.setValue(newData)
    }
    
    private func synchronize(
        with projects: [ProjectDTO],
        to repository: PersistentRepositoryProtocol
    ) {
        let formattedProjects = projects.compactMap {
            parse(from: $0)
        }
        
        repository.deleteAll()
        repository.create(projectEntities: formattedProjects)
    }
}
