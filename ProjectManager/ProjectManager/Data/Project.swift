import Foundation

struct Project: Codable, Listable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifier: UUID?
    
    init(name: String, detail: String, deadline: Date, indentifier: UUID? = nil) {
        self.name = name
        self.detail = detail
        self.deadline = deadline
    }
}
