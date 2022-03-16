import Foundation
import FirebaseFirestore

class FirebaseTaskListRepository {
    private enum Contant {
        static let collectionName = "ProjectManagerTaskList"
        static let id = "id"
        static let title = "title"
        static let desc = "desc"
        static let deadline = "deadline"
        static let status = "status"
    }
    var ref: DocumentReference?
    let store = Firestore.firestore()
    
    
    func syncTask(_ entityTask: FirebaseEntityTask) {
        let createData: [String: Any] = [
            Contant.id: entityTask.id,
            Contant.title: entityTask.title,
            Contant.desc: entityTask.description,
            Contant.deadline: entityTask.deadline,
            Contant.status: entityTask.progressStatus
        ]
        
        store
            .collection(Contant.collectionName)
            .document(entityTask.id)
            .setData(createData) { error in
                if let error = error {
                    print("Error adding document: \(String(describing: error))")
                }
            }
    }
    
    func createEntityTask(entityTask: FirebaseEntityTask, complition: @escaping () -> Void) {
        let createData: [String: Any] = [
            Contant.id: entityTask.id,
            Contant.title: entityTask.title,
            Contant.desc: entityTask.description,
            Contant.deadline: entityTask.deadline,
            Contant.status: entityTask.progressStatus
        ]
        
        store
            .collection(Contant.collectionName)
            .document(entityTask.id)
            .setData(createData) { error in
                print("Error adding document: \(String(describing: error))")
            }
        complition()
    }
    
    func fetchEntityTask(complition: @escaping ([FirebaseEntityTask]) -> Void) {
        var entityTaskList = [FirebaseEntityTask]()
        store
            .collection(Contant.collectionName)
            .getDocuments { data, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                guard let data = data else {
                    return
                }
                data.documents.forEach { document in
                    let id = document.data()[Contant.id] as? String ?? ""
                    let title = document.data()[Contant.title] as? String ?? ""
                    let description = document.data()[Contant.desc] as? String ?? ""
                    let deadline = document.data()[Contant.deadline] as? TimeInterval ?? 0
                    let progressStatus = document.data()[Contant.status] as? String ?? ""
                    let entityTask = FirebaseEntityTask(
                        id: id,
                        title: title,
                        description: description,
                        deadline: deadline,
                        progressStatus: progressStatus
                    )
                    print("\(document.documentID) => \(document.data())")
                    entityTaskList.append(entityTask)
                }
                complition(entityTaskList)
            }
    }
    
    func updateEntityTask(
        id: String,
        title: String,
        description: String,
        deadline: Date,
        complition: @escaping () -> Void) {
            let updateData: [String: Any] = [
                Contant.title: title,
                Contant.desc: description,
                Contant.deadline: deadline.timeIntervalSince1970
            ]
            
            store
                .collection(Contant.collectionName)
                .document(id)
                .getDocument { data, error in
                    if let error = error {
                        print("Document error: \(error)")
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    data.reference.setData(updateData, merge: true) { error in
                        print("Error adding document: \(String(describing: error))")
                    }
                    complition()
                }
        }

    func updateEntityTaskStatus(id: String, status: String, complition: @escaping () -> Void) {
        let updateStateData = ["status": status]
        
        store
            .collection(Contant.collectionName)
            .document(id)
            .getDocument { data, error in
                if let error = error {
                    print("Document error: \(error)")
                    return
                }
                guard let data = data else {
                    return
                }
                data.reference.setData(updateStateData, merge: true) { error in
                    print("Error adding document: \(String(describing: error))")
                    return
                }
                complition()
            }
    }
    
    func deleteEntityTask(id: String, complition: @escaping () -> Void) {
        store
            .collection(Contant.collectionName)
            .document(id)
            .getDocument { data, error in
                if let error = error {
                    print("Document error: \(error)")
                    return
                }
                guard let data = data else {
                    return
                }
                data.reference.delete { error in
                    print("Error adding document: \(String(describing: error))")
                    return
                }
                complition()
            }
    }
}
