import Foundation

struct MemoryUseCase {
    private let repository: Repositoryable
    
    init(repository: Repositoryable = MemoryRepository()) {
        self.repository = repository
    }
}

extension MemoryUseCase: UseCase {
    func create(_ project: Project, completion: ((Project?) -> Void)?) {
        repository.create(project) { project in
            completion?(project)
        }
    }
    
    func update(_ project: Project?, completion: ((Project?) -> Void)?) {
        guard let project = project else {
            completion?(nil)
            return
        }
        repository.update(with: project) { project in
            completion?(project)
        }
    }
    
    func delete(_ project: Project?, completion: ((Project?) -> Void)?) {
        guard let project = project else {
            completion?(nil)
            return
        }
        repository.delete(project) { project in
            completion?(project)
        }
    }
    
    func fetch() -> [Project] {
        return repository.fetch()
    }
}
