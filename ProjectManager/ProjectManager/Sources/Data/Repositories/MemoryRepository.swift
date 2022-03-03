import Foundation

final class MemoryRepository {
    private let storage: Storageable

    init(storage: Storageable = MemoryStorage()) {
        self.storage = storage
    }
}

extension MemoryRepository: Repositoryable {
    func create(_ item: Project, completion: ((Project?) -> Void)?) {
        storage.create(item) { item in
            completion?(item)
        }
    }
    
    func update(with item: Project, completion: ((Project?) -> Void)?) {
        storage.update(item) { item in
            completion?(item)
        }
    }
    
    func delete(_ item: Project, completion: ((Project?) -> Void)?) {
        storage.delete(item) { item in
            completion?(item)
        }
    }
    
    func fetch() -> [Project] {
        return storage.fetch()
    }
}
