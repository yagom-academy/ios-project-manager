import Foundation
import FirebaseFirestore
import Firebase

class TaskListRepository {
    var ref: DocumentReference?
    let db = Firestore.firestore()
    
//    func insertData() {
//        ref = db.collection("test").addDocument(data: [
//            "id": task.id.uuidString,
//            "title": task.title,
//            "desc": task.description,
//            "deadline": task.deadline,
//            "status": task.progressStatus.name
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(self.ref!.documentID)")
//            }
//        }
//    }
    
    func read(complition: @escaping ([EntityTask]) -> Void) {
        var entityTaskList = [EntityTask]()
        db.collection("test").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let querySnapshot = querySnapshot else {
                    return
                }
                for document in querySnapshot.documents {
                    let id = document.data()["id"] as? String ?? ""
                    let title = document.data()["title"] as? String ?? ""
                    let description = document.data()["description"] as? String ?? ""
                    let deadline = document.data()["deadline"] as? TimeInterval ?? 0
                    let progressStatus = document.data()["progressStatus"] as? String ?? ""
                    let entityTask = EntityTask(
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
}
