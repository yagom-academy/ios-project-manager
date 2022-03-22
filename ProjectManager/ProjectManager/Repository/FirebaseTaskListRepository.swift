import Foundation
import FirebaseFirestore
import Network

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
    
    func mergeTask(_ entityTask: FirebaseEntityTask) {
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
    
    func fetchTask(complition: @escaping (Result<[FirebaseEntityTask], FirebaseError>) -> Void) {
        var entityTaskList = [FirebaseEntityTask]()
        store
            .collection(Contant.collectionName)
            .getDocuments { data, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                    complition(.failure(.fetchFailed))
                }
                guard let data = data else {
                    complition(.failure(.fetchFailed))
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
                complition(.success(entityTaskList))
            }
    }
    
    func createTask(entityTask: FirebaseEntityTask, complition: @escaping (Result<Bool, FirebaseError>) -> Void) {
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
                    complition(.failure(.createFailed))
                }
            }
        complition(.success(true))
    }
    
    func updateTask(
        id: String,
        title: String,
        description: String,
        deadline: Date,
        complition: @escaping (Result<Bool, FirebaseError>) -> Void
    ) {
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
                        complition(.failure(.updateFailed))
                    }
                    guard let data = data else {
                        return
                    }
                    data.reference.setData(updateData, merge: true) { error in
                        if let error = error {
                            print("Error adding document: \(String(describing: error))")
                            complition(.failure(.updateFailed))
                        }
                    }
                    complition(.success(true))
                }
        }
    
    func updateTaskStatus(
        id: String,
        taskStatus: String,
        complition: @escaping (Result<Bool, FirebaseError>) -> Void
    ) {
        let updateStatusData = ["status": taskStatus]
        
        store
            .collection(Contant.collectionName)
            .document(id)
            .getDocument { data, error in
                if let error = error {
                    print("Document error: \(error)")
                    complition(.failure(.updateFailed))
                }
                guard let data = data else {
                    complition(.failure(.updateFailed))
                    return
                }
                data.reference.setData(updateStatusData, merge: true) { error in
                    if let error = error {
                        print("Error adding document: \(String(describing: error))")
                        complition(.failure(.updateFailed))
                    }
                }
                complition(.success(true))
            }
    }
    
    func deleteTask(id: String, complition: @escaping (Result<Bool, FirebaseError>) -> Void) {
        store
            .collection(Contant.collectionName)
            .document(id)
            .getDocument { data, error in
                if let error = error {
                    print("Document error: \(error)")
                    complition(.failure(.deleteFailed))
                }
                guard let data = data else {
                    complition(.failure(.deleteFailed))
                    return
                }
                data.reference.delete { error in
                    if let error = error {
                        print("Error adding document: \(String(describing: error))")
                        complition(.failure(.deleteFailed))
                    }
                }
                complition(.success(true))
            }
    }
}
