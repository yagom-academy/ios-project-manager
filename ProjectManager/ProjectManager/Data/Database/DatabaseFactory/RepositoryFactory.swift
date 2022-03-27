import FirebaseFirestore
import CoreData
import UIKit

enum RepositoryFactory {
    
    static func assignRepository(repository: RepositoryType) -> DataRepository {
        
        let defaultCoreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let defaultFireStore = Firestore.firestore()
        
        switch repository {
        case .coreData:
            
            guard let context = defaultCoreDataContext
            else {
                return MemoryDataBase()
            }
            return CoredataRepository(context: context)
        case .fireStore:
            return FireStoreDataBase(database: defaultFireStore)
        case .memory:
            return MemoryDataBase()
        }
    }
    
    enum DatabaseError: Error, CaseIterable {
        
        case notFoundContext
    }
}
