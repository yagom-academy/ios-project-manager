import Foundation


protocol WorkManagable {
    
    var todoList: [Work] { get }
    var doingList: [Work] { get }
    var doneList: [Work] { get }
    
    func create(_ data: Work)
    func delete(_ data: Work)
    func update(_ data: Work, title: String?, body: String?, date: Date?, category: Work.Category)
    
}
