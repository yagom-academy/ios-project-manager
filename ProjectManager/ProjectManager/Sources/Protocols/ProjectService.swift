import Foundation

protocol ProjectService {
    func create(_ item: Project, completion: ((Project?) -> Void)?)
    func update(with item: Project, completion: ((Project?) -> Void)?)
    func delete(_ item: Project, completion: ((Project?) -> Void)?)
}
