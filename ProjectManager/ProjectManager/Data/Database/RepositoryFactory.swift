import Foundation
import FirebaseFirestore
import CoreData
import UIKit

final class RepositoryFactory {
    
    private let defaultCoreDataContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private let defaultFireStore = Firestore.firestore()
    
     func assignListManger(repository: RepositoryType) throws -> DataRepository {
         
         guard let context = defaultCoreDataContext
         else {
             throw DatabaseError.notFoundContext
         }
        
        switch repository {
        case .coreData:
            return CoredataRepository(context: context)
        case .fireStore:
            return FireStoreRepository(database: self.defaultFireStore)
        }
    }
    
    enum DatabaseError: Error, CaseIterable {
        
        case notFoundContext
    }
}
