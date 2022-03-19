import Foundation
import Firebase
import FirebaseFirestore
import RxSwift

final class FireStoreRepository: DataRepository {
    
    private let dataBase: Firestore?
    private var list = [Listable]()
    private let sampleList = Project(name: "", detail: "", deadline: Date(), indentifier: "123", progressState: ProgressState.doing.description)
    
    init(database: Firestore) {
        self.dataBase = database
    }
    
    func create(object: Listable) {
        let attributes = convertListToAttributes(from: object)
        var attibutesToMerge = attributes
        let documentPath = UUID().uuidString
        attibutesToMerge.merge(["identifer": documentPath]) { _, _ in
        }
        reference().document(documentPath).setData(attibutesToMerge)
    }
    
    func read(identifier: String) -> Listable? {
        self.list.filter { $0.identifier == identifier }.first
    }
    
    func update(identifier: String, how object: Listable)  {
        let attributes = convertListToAttributes(from: object)
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
    
    func extractRxAll() -> Observable<[Listable]> {
        return Observable.create { emitter in
            let lists = self.extractAll()
            emitter.onNext(lists)
            return Disposables.create()
        }
    }
    
    private func convertListToAttributes(from list: Listable) -> [String: Any] {
        var attributes = [String: Any]()
        attributes.updateValue(list.name, forKey: "name")
        attributes.updateValue(list.detail, forKey: "detail")
        attributes.updateValue(list.identifier, forKey: "identifier")
        attributes.updateValue(list.progressState, forKey: "progressState")
        attributes.updateValue(list.deadline, forKey: "deadline")
        return attributes
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
