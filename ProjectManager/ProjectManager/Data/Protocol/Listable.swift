import Foundation

protocol Listable {
    
    var name: String { get set }
    var detail: String { get set }
    var deadline: Date { get set }
    var identifier: String? { get set }
    var progressState: String { get set }
}
