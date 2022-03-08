import Foundation
import Firebase
import FirebaseFirestore

final class FireStoreRepository: DataRepository {
    
    var dataBase = Firestore.firestore()
    var list: [Listable] = [] 
    
    func creat(attributes: [String: Any]) {
        var attibutesToMerge = attributes
        let documentPath = UUID().uuidString
        attibutesToMerge.merge(["identifer": documentPath]) { _, _ in
        }
        reference().document(documentPath).setData(attibutesToMerge)
    }
    
    func read(identifier: String) -> Listable? {
        self.list.filter { $0.identifier == identifier }.first
    }
    
    func update(identifier: String, how attributes: [String: Any])  {
        reference().document(identifier).getDocument { (document , error) in
            if let document = document, document.exists {
                let documentDescription = document.data().map(String.init(describing:)) ?? "nil"
            }
        }
    }
    
    func delete(identifier: String) {
        reference().document(identifier).delete()
    }
    
    func fetch() {
        <#code#>
    }
    
    private func reference(to collectionReference: String = "ProjectManager") -> CollectionReference {
        return Firestore.firestore().collection(collectionReference)
    }
    
    private func subscibe() {
        reference().addSnapshotListener { (snapshot, error) in
            if let snapshot = snapshot, !snapshot.isEmpty {
                self.list = snapshot.documents
            }
        }
    }
}
