import Foundation

final class RepositoryFactory {
    
    public func assignListManger(repository: RepositoryType) -> DataRepository {
        
        switch repository {
        case .CoreData:
            return CoredataRepository()
        case .FireStore:
            return FireStoreRepository()
        }
    }
}
