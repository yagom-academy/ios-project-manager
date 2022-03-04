import Foundation

protocol DataManager {
    associatedtype StorageType
    
    var todoList: [StorageType] { get }
    var doingList: [StorageType] { get }
    var doneList: [StorageType] { get }
    
    func create(_ data: StorageType)
    func delete(_ data: StorageType) throws
    func update(_ data: StorageType, title: String?, body: String?, date: Date?)
    func fetchAll() -> [StorageType]
}
