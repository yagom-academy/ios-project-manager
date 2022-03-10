import Foundation

final class RepositoryChecker {
    
    static var currentRepository: RepositoryType = .coreData
    
    private init() {
        
    }
    
    static func switchRepository(to repository: RepositoryType) {
        RepositoryChecker.currentRepository = repository
    }
}
