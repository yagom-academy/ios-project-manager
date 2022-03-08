import Foundation
import Firebase
import FirebaseFirestore

final class FireStoreRepository: DataRepository {
    
    var dataBase = Firestore.firestore()
    var list: [Listable] = [] 
    
    func creatProject(attributes: [String: Any])  {
        let add = reference().addDocument(data: attributes)
        let documentId = add.documentID
        reference().document("\(documentId)").setValuesForKeys(["identifier": documentId])
    }
    
    func readProject(index: IndexPath) -> Listable? {
//        reference().document("123").getDocuments { (snaphot, _ ) in
//            guard let snapshot = snaphot
//            else {
//                return nil
//            }
//        }
    }
    
    func updateProject(to index: IndexPath, how attributes: [String: Any])  {
        reference().document("id").setData(attributes)
    }
    
    func deleteProject(index: IndexPath) {
        reference().document("id").delete()
    }
    
    func fetch() {
        <#code#>
    }
    
    private func reference(to collectionReference: String = "ProjectManager") -> CollectionReference {
        return Firestore.firestore().collection("\(collectionReference)")
    }
}
