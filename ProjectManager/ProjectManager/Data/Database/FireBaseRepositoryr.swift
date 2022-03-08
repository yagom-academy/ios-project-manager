import Foundation
import Firebase
import FirebaseFirestore

final class FireStoreRepository: DataRepository {
    
    var dataBase = Firestore.firestore()
    var list = [Listable]()
    
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
        reference().document(identifier).updateData(attributes) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(identifier: String) {
        reference().document(identifier).delete()
    }
    
    func fetch() {
        var lists = [Listable]()
        reference().getDocuments { (snapshot, _) in
            if let snapshot = snapshot, !snapshot.isEmpty {
                snapshot.documents.forEach { document in
                    let data = document.data()
                    let project = Project.convertDictionaryToInstance(attributes: data)
                    lists.append(project ?? Project(name: "", detail: "", deadline: Date(), indentifier: nil))
                }
            }
        }
        self.list = lists
    }
    
    private func reference(
        to collectionReference: String = "ProjectManager"
    ) -> CollectionReference {
        return Firestore.firestore().collection(collectionReference)
    }
}
