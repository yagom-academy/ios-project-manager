import Foundation

protocol UseCase {
    func create(_ project: Project, completion: ((Project?) -> Void)?)
    func update(_ project: Project?, completion: ((Project?) -> Void)?)
    func delete(_ project: Project?, completion: ((Project?) -> Void)?)
    func fetch() -> [Project]
}
