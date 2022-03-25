import Foundation
import FirebaseDatabase


private enum Data {
    
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

    func addData(title: String, body: String, dueDate: Date) {
        let work = ParsedWork(id: UUID(), title: title, body: body, dueDate: dueDate, categoryTag: 0)
        let firebaseData = FireBaseWork(work)
        database.child(Data.pathName).child(work.id.uuidString).setValue(firebaseData.data)
    }
                        
    func deletedData() {
    
    }
                        
    func updateData() {
        
    }
                        
}
