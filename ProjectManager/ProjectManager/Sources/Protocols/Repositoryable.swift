import Foundation

protocol Repositoryable {
    func create(_ item: Project, completion: ((Project?) -> Void)?)
    func update(with item: Project, completion: ((Project?) -> Void)?)
    func delete(_ item: Project, completion: ((Project?) -> Void)?)
    func fetch() -> [Project]
}
