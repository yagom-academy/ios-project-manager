import Foundation

struct Project: Codable, Listable {
    
    var name: String
    var detail: String
    var deadline: Date
    var identifier: UUID?
    var progressCondition: Int16
}
