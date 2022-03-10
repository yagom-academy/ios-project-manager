import Foundation
import Firebase
import FirebaseFirestore

final class FireStoreRepository: DataRepository {
    
    private let dataBase: Firestore?
    private var list = [Listable]()
    private let sampleList = Project(name: "", detail: "", deadline: Date(), indentifier: "123", progressState: ProgressState.doing.description)
    init(database: Firestore) {
        self.dataBase = database
    }
    
    func create(attributes: [String: Any]) {
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
                    lists.append(project ?? self.sampleList)
                }
            }
        }
        self.list = lists
    }
    
    func extractAll() -> [Listable] {
        self.fetch()
        return list
    }
    
    private func reference(
        to collectionReference: String = "ProjectManager"
    ) -> CollectionReference {
        
        guard let dataBase = dataBase
        else {
            return Firestore.firestore().collection(collectionReference)
        }

        return dataBase.collection(collectionReference)
    }
}
