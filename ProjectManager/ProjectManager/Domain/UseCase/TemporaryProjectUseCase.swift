//
//  ProjectDAO.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

struct TemporaryProjectUseCase: ProjectUseCaseProtocol {
    private var temporaryStore = [ProjectModel]()
    
    mutating func create(data: ProjectModel) {
        temporaryStore.append(data)
    }
                    
    func read() -> [ProjectModel] {
        return temporaryStore
    }
    
    mutating func update(id: String, data: ProjectModel) {
        delete(id: id)
        temporaryStore.append(data)
    }
    
    mutating func delete(id: String) {
        temporaryStore = temporaryStore.filter { $0.id != id }
    }
}
