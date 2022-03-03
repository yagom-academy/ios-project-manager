import Foundation

final class TodoListFactory {
    
    public func assignListManger(database: DatabaseType) -> ListManager {
        
        switch database {
        case .CoreData:
            return CoredataListManger()
        case .FireBase:
            return FireBaseListManger()
        case .Mock:
            return MockListManager() 
        }
    }
}
