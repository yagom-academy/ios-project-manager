import Foundation

struct Thing: Codable {
    var id: Int? = nil
    var title: String? = nil
    var description: String? = nil
    var state: State? = nil
    var dueDate: Double? = nil
    var updatedAt: Double? = nil
    
    init(id: Int, title: String?, description: String?, state: State, dueDate: Double, updatedAt: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.state = state
        self.dueDate = dueDate
        self.updatedAt = updatedAt
    }
    
    init(title: String?, description: String?, state: State?, dueDate: Double?) {
        self.title = title
        self.description = description
        self.state = state
        self.dueDate = dueDate
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, state
        case dueDate = "due_date"
        case updatedAt = "updated_at"
    }
}

extension Thing: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Thing: Equatable {
    static func ==(lhs: Thing, rhs: Thing) -> Bool {
        return lhs.id == rhs.id
    }
}
