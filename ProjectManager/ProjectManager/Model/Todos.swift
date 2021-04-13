//
//  Todos.swift
//  ProjectManager
//
//  Created by 김태형 on 2021/04/02.
//
import UIKit
import MobileCoreServices

final class Todos {
    private init() { }
    static var common = Todos()
    
    var todoList: [Todo] = [Todo(title: "라자냐 만들기", description: "어렵다", deadline: 1611123563.719116)]
    var doingList: [Todo] = [Todo(title: "볼펜 사기 사기 사기 사기 사기 사기 당했어 ", description: "문구점에서 볼펜을 12091203 8 10984 50 9382503 50596 45 69 자루 사요 사요 사요 사요 사요 사요 129038098529859045 9012389085928359048504534", deadline: 1611123563.712932)]
    var doneList: [Todo] = [Todo(title: "저녁 재료사기", description: "마트에서", deadline: 1611123563.702304)]

    private func deleteItem(at index: Int, from listName: String) {
        if listName == String.todo {
            self.todoList.remove(at: index)
        } else if listName == String.doing {
            self.doingList.remove(at: index)
        } else {
            self.doneList.remove(at: index)
        }
    }
    
    private func insertItem(todo: Todo, at index: Int, from listName: String) {
        if listName == String.todo {
            self.todoList.insert(todo, at: index)
        } else if listName == String.doing {
            self.doingList.insert(todo, at: index)
        } else {
            self.doneList.insert(todo, at: index)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadView"), object: nil)
    }
    
    func dragItems(for indexPath: IndexPath, from tableView: String) -> [UIDragItem] {
        var todo = Todo(title: String.empty, description: String.empty, deadline: 0)
        if tableView == String.todo {
            todo = todoList[indexPath.row]
        } else if tableView == String.doing {
            todo = doingList[indexPath.row]
        } else {
            todo = doneList[indexPath.row]
        }
        let data = try? JSONEncoder().encode(todo)
        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypeJSON as String, visibility: .all) { completion in
            completion(data, nil)
            return nil
        }
        self.deleteItem(at: indexPath.row, from: tableView)
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    func dropItems(for indexPath: IndexPath, from tableView: String, dropItems: [UITableViewDropItem]) {
        guard let dropItem = dropItems.first else {
            return
        }
        dropItem.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypeJSON as String){ data, error in
            guard error == nil else{
                return
            }
            guard let data = data else {
                return
            }
            guard let todo = try? JSONDecoder().decode(Todo.self, from: data) else {
                return
            }
            self.insertItem(todo: todo, at: indexPath.row, from: tableView)
            
        }
    }
}
