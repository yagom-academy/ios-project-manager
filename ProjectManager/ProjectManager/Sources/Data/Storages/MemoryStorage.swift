import Foundation

final class MemoryStorage {
    private(set) var projects: [Project]
    
    init(projects: [Project] = []) {
        self.projects = projects
    }
}

extension MemoryStorage: Storageable {
    func create(_ item: Project, completion: ((Project?) -> Void)?) {
        projects.append(item)
        completion?(item)
    }
    
    func update(_ item: Project, completion: ((Project?) -> Void)?) {
        projects.indices
            .filter { projects[$0].id == item.id }.first
            .flatMap {
                projects[$0] = item
                completion?(projects[$0])
            }
    }
    
    func delete(_ item: Project, completion: ((Project?) -> Void)?) {
        projects.indices
            .filter { projects[$0].id == item.id }.first
            .flatMap {
                completion?(projects.remove(at: $0))
            }
    }
    
    func fetch() -> [Project] {
        return projects
    }
}
