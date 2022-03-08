import Foundation

final class RepositoryFactory {
    
    public func assignListManger(database: RepositoryType) -> DataRepository {
        
        switch database {
        case .CoreData:
            return CoredataRepository()
        case .FireStore:
            return FireStoreRepository()
        case .Mock:
            return MockListManager() 
        }
    }
}
