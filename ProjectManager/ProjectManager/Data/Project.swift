import Foundation

struct Project: Listable, Codable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifier: String
    var progressState: String
    
    init(name: String, detail: String, deadline: Date, indentifier: String, progressState: String) {
        self.name = name
        self.detail = detail
        self.deadline = deadline
        self.identifier = indentifier
        self.progressState = progressState
    }
}

extension Project {
    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
