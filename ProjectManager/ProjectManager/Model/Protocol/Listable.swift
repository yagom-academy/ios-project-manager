import Foundation

protocol Listable {
    
    var name: String { get }
    var detail: String { get }
    var deadline: Date { get }
    var identifier: UUID? { get }
    var progressCondition: Int16 { get }
}
