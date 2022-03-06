import Foundation
import Firebase
import FirebaseFirestoreSwift

final class FireBaseListManger: DataRepository, FireStoreUseCase {
    
    var path: String = "ProjectManager/Project"
    var dataBase = Firestore.firestore()
    
    func subscribe() {
        <#code#>
    }
    
    func removeDataBase() {
        <#code#>
    }
    
    
    var list: [Listable] = [] 
    
    func creatProject(attributes: [String: Any]) -> Listable {
        <#code#>
    }
    
    func readProject(index: IndexPath) -> Listable {
        <#code#>
    }
    
    func updateProject(to index: IndexPath, how attributes: [String: Any]) -> Listable {
        <#code#>
    }
    
    func deleteProject(index: IndexPath) {
        <#code#>
    }
    
    func fetch() {
        <#code#>
    }
}
