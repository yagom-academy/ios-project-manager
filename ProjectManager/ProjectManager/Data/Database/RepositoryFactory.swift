import Foundation
import FirebaseFirestore
import CoreData
import UIKit

enum RepositoryFactory {
    
     static func assignRepository(repository: RepositoryType) -> DataRepository {
         
          let defaultCoreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
          let defaultFireStore = Firestore.firestore()
         
         guard let context = defaultCoreDataContext
         else {
             return MockDataRepository()
         }
        
        switch repository {
        case .coreData:
            return CoredataRepository(context: context)
        case .fireStore:
            return FireStoreRepository(database: defaultFireStore)
        case .mock:
            return MockDataRepository()
        }
    }
    
    enum DatabaseError: Error, CaseIterable {
        
        case notFoundContext
    }
}
