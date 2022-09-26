//
//  TemporaryProjectRepository.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/19.
//

struct TemporaryProjectRepository: ProjectRepositoryProtocol {
    private var temporaryStore: [ProjectModel]
    
    init(temporaryStore: [ProjectModel]) {
        self.temporaryStore = temporaryStore
    }
    
    mutating func create(data: ProjectModel) {
        temporaryStore.append(data)
    }
    
    func read() -> [ProjectModel] {
        return temporaryStore
    }
    
    mutating func update(id: String,
                         data: ProjectModel) {
        temporaryStore.indices.forEach {
            temporaryStore[$0] = temporaryStore[$0].id == id ? data : temporaryStore[$0]
        }
    }
    
    mutating func delete(id: String) {
        temporaryStore.removeAll(where: { $0.id == id })
    }
}
