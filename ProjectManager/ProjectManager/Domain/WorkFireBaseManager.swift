import Foundation
import FirebaseDatabase


private enum Data {
    
    static let empty = ""
    static let pathName = "Works"
    static let id = "id"
    static let title = "title"
    static let body = "body"
    static let dueDate = "dueDate"
    static let category = "category"
    
}

class WorkFireBaseManager {
    
    static let shared = WorkFireBaseManager()
    
    private (set) var works = [ParsedWork]()
    private let database = Database.database().reference()
    
    private init() { }
    
    func fetchAllData() {
        database.child(Data.pathName).observe(.value) { [weak self] snapshot in
            if let works = snapshot.value as? [String: Any] {
                works.values.forEach { work in
                    guard let work = work as? [String: Any],
                          let id = work[Data.id] as? String,
                          let title = work[Data.title] as? String,
                          let body = work[Data.body] as? String,
                          let dueDate = work[Data.dueDate] as? Double,
                          let category = work[Data.category] as? Int else {
                        return
                    }
                    
                    let firebaseWork = FireBaseWork(
                        id: id,
                        title: title,
                        body: body,
                        dueDate: dueDate,
                        category: category
                    )
                    
                    self?.works.append(ParsedWork(from: firebaseWork))
                }
            }
        }
    }

    func addData(id: UUID?, title: String, body: String, dueDate: Date) {
        let work = ParsedWork(id: id ?? UUID(), title: title, body: body, dueDate: dueDate, categoryTag: 0)
        let firebaseData = FireBaseWork(work)
        database.child(Data.pathName).child(work.id.uuidString).setValue(firebaseData.parsed)
    }
                        
    func deletedData() {
    
    }
                        
    func updateData(id: UUID, title: String?, body: String?, date: Date?, category: Int16) {
        let work = ParsedWork(
            id: id,
            title: title ?? Data.empty,
            body: body ?? Data.empty,
            dueDate: date ?? Date(),
            categoryTag: category
        )
        let firebaseData = FireBaseWork(work)
        database.child(Data.pathName).updateChildValues([id.uuidString: firebaseData.parsed])
    }
                        
}
