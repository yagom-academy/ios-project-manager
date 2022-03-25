import Foundation


private enum Content {
    
    static let empty = ""
    static let id = "id"
    static let title = "title"
    static let body = "body"
    static let dueDate = "dueDate"
    static let category = "category"
    
}

struct FireBaseWork {
    
    let id: String
    var title: String
    var body: String
    var dueDate: Double
    var category: Int
    
    var data: [String: Any] {
        return [
            Content.id: id,
            Content.title: title,
            Content.body: body,
            Content.dueDate: dueDate,
            Content.category: category
        ]
    }
    
}

extension FireBaseWork {
    
    init(_ work: ParsedWork) {
        self.id = work.id.uuidString
        self.title = work.title
        self.body = work.body
        self.dueDate = work.dueDate.timeIntervalSince1970
        self.category = Int(work.categoryTag)
    }
    
}
