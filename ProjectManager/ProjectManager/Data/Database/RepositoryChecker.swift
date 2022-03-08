import Foundation

class RepositoryChecker {
    
    static var currentRepository: RepositoryType = .CoreData
    
    private init() {
        
    }
    
    static func switchRepository(to repository: RepositoryType) {
        RepositoryChecker.currentRepository = repository
    }
}
