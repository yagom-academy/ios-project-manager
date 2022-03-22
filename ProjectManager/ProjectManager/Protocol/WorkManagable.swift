import Foundation
import RxSwift


protocol WorkManagable {
    
    var todoList: [Work] { get }
    var doingList: [Work] { get }
    var doneList: [Work] { get }
    
    func create(title: String, body: String, dueDate: Date)
    func delete(_ data: Work)
    func update(_ data: Work, title: String?, body: String?, date: Date?, category: Int16)
    
}
