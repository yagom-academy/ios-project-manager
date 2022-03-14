import Foundation
import FirebaseFirestore

class TaskListRepository {
    var ref: DocumentReference?
    let store = Firestore.firestore()
    
    func createEntityTask(entityTask: EntityTask, complition: @escaping ([EntityTask]) -> Void) {
        ref = store.collection("test").addDocument(data: [
            "id": entityTask.id,
            "title": entityTask.title,
            "desc": entityTask.description,
            "deadline": entityTask.deadline,
            "status": entityTask.progressStatus
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
    }
    
    func fetchEntityTask(complition: @escaping ([EntityTask]) -> Void) {
        var entityTaskList = [EntityTask]()
        store.collection("test").getDocuments { data, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let data = data else {
                    return
                }
                for document in data.documents {
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
