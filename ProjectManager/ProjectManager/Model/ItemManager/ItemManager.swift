import Foundation

final class ItemManager {
    static let shared = ItemManager()
    var todoList = [Item]()
    var doingList = [Item]()
    var doneList = [Item]()
    
    private init() {}
    
    func createItem(_ title: String, _ description: String, dueDate: Int) -> Item {
        return Item(title: title, description: description, progressStatus: "TODO", dueDate: dueDate)
    }
    
    func addTodoItem(_ item: Item) {
        todoList.append(item)
    }
    
    func readTodoItems() -> [Item] {
        return todoList
    }
    
    func updateTodoItem(at index: Int, with item: Item) {
       todoList[index].updateItem(item)
    }
    
    func updateDoingItem(at index: Int, with item: Item) {
       doingList[index].updateItem(item)
    }
    
    func updateDoneItem(at index: Int, with item: Item) {
       doneList[index].updateItem(item)
    }
    
    func deleteTodoItem(at index: Int) {
        todoList.remove(at: index)
    }
    
    func deleteDoingItem(at index: Int) {
        doingList.remove(at: index)
    }
    
    func deleteDoneItem(at index: Int) {
        doneList.remove(at: index)
    }
}
let itemManager = ItemManager.shared
