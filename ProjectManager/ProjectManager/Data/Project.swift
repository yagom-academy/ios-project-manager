import Foundation

struct Project: Listable, Codable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifier: String?
    var progressState: String
    
    init(name: String, detail: String, deadline: Date, indentifier: UUID? = nil) {
        self.name = name
        self.detail = detail
        self.deadline = deadline
    }
}

extension Project {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
