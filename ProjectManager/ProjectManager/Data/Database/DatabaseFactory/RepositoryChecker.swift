import Foundation

final class RepositoryChecker {
    
    static var currentRepository: RepositoryType = .memory
    
    private init() {
        
    }
    
    static func switchRepository(to repository: RepositoryType) {
        RepositoryChecker.currentRepository = repository
    }
}
