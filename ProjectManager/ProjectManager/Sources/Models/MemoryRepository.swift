import Foundation

final class MemoryRepository {
    private(set) var projects: [Project]
    
    init(projects: [Project] = []) {
        self.projects = projects
    }
}

extension MemoryRepository: ProjectService {
    func create(_ item: Project, completion: ((Project?) -> Void)? = nil) {
        projects.append(item)
        completion?(item)
    }
    
    func update(with item: Project, completion: ((Project?) -> Void)? = nil) {
        _ = projects.indices
            .filter { projects[$0].id == item.id }.first
            .flatMap {
                projects[$0] = item
                completion?(projects[$0])
            }
    }
    
    func delete(_ item: Project, completion: ((Project?) -> Void)? = nil) {
        _ = projects.indices
            .filter { projects[$0].id == item.id }.first
            .flatMap {
                completion?(projects.remove(at: $0))
            }
    }
}
