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
    
    func createEntityTask(entityTask: FirebaseEntityTask, complition: @escaping () -> Void) {
        let createData: [String: Any] = [
            Contant.id: entityTask.id,
            Contant.title: entityTask.title,
            Contant.desc: entityTask.description,
            Contant.deadline: entityTask.deadline,
            Contant.status: entityTask.progressStatus
        ]
        
        ref = store
            .collection(Contant.collectionName)
            .addDocument(data: createData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added with ID: \(self.ref!.documentID)")
                    complition()
                }
            }
    }
    
    func fetchEntityTask(complition: @escaping ([FirebaseEntityTask]) -> Void) {
        var entityTaskList = [FirebaseEntityTask]()
        store
            .collection(Contant.collectionName)
            .getDocuments { data, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    guard let data = data else {
                        return
                    }
                    for document in data.documents {
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
                .whereField(Contant.id, isEqualTo: id)
                .getDocuments { data, error in
                    if let error = error {
                        print("Document error: \(error)")
                    } else {
                        if let document = data?.documents.first {
                            document.reference.setData(updateData, merge: true) { error in
                                if let error = error {
                                    print("Error adding document: \(error)")
                                } else {
                                    print("Document updated with ID: \(document.documentID)")
                                    complition()
                                }
                            }
                        }
                    }
                }
        }
    
    func updateEntityTaskStatus(id: String, status: String, complition: @escaping () -> Void) {
        let updateStateData = ["status": status]
        
        store
            .collection(Contant.collectionName)
            .whereField(Contant.id, isEqualTo: id)
            .getDocuments { data, error in
                if let error = error {
                    print("Document error: \(error)")
                } else {
                    if let document = data?.documents.first {
                        document.reference.setData(updateStateData, merge: true) { error in
                            if let error = error {
                                print("Error adding document: \(error)")
                            } else {
                                print("Document updated with ID: \(document.documentID)")
                                complition()
                            }
                        }
                    }
                }
            }
    }
    
    func deleteEntityTask(id: String, complition: @escaping () -> Void) {
        store
            .collection(Contant.collectionName)
            .whereField(Contant.id, isEqualTo: id)
            .getDocuments { data, error in
                if let error = error {
                    print("Document error: \(error)")
                } else {
                    if let document = data?.documents.first {
                        document.reference.delete { error in
                            print("Error adding document: \(String(describing: error))")
                            return
                        }
                        print("Document updated with ID: \(document.documentID)")
                        complition()
                    }
                }
            }
    }
}
