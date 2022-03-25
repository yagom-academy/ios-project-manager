import Foundation


struct ParsedWork {
    
    let id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var categoryTag: Int16
    
}

extension ParsedWork {
    
    init(from work: FireBaseWork) {
        self.id = UUID(uuidString: work.id) ?? UUID()
        self.title = work.title
        self.body = work.body
        self.dueDate = Date(timeIntervalSince1970: work.dueDate)
        self.categoryTag = Int16(work.category)
    }
    
}
