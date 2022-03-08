import Foundation

protocol Listable {
    
    var name: String { get }
    var detail: String { get }
    var deadline: Date { get }
    var identifier: String? { get set }
    var progressState: String { get set }
}
