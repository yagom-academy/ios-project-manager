//import UIKit
//
class Board {
    var title: String
    var items: [Item]
    
    init(title: String, items: [Item]) {
        self.title = title
        self.items = items
    }
    
    func createItem(_ title: String, _ description: String, dueDate: Int) -> Item {
        return Item(title: title, description: description, progressStatus: "TODO", dueDate: dueDate)
    }
    
    func addTodoItem(_ item: Item) {
        items.append(item)
    }
    
    func readTodoItems() -> [Item] {
        return items
    }
    
    func updateTodoItem(at index: Int, with item: Item) {
       items[index].updateItem(item)
    }

    func deleteTodoItem(at index: Int) {
        items.remove(at: index)
    }
}
