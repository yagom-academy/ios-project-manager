//
//  MainViewModel.swift
//  ProjectManager
//  Created by inho on 2023/01/18.
//

import Foundation

final class MainViewModel {
    private var totalListItems: [[ListItem]] = [[], [], []] {
        didSet {
            todoHandler?(totalListItems[0])
            doingHandler?(totalListItems[1])
            doneHandler?(totalListItems[2])
        }
    }
    
    private var todoHandler: (([ListItem]) -> Void)?
    private var doingHandler: (([ListItem]) -> Void)?
    private var doneHandler: (([ListItem]) -> Void)?
    
    func bindTodo(_ handler: @escaping ([ListItem]) -> Void) {
        todoHandler = handler
    }
    
    func bindDoing(_ handler: @escaping ([ListItem]) -> Void) {
        doingHandler = handler
    }
    
    func bindDone(_ handler: @escaping ([ListItem]) -> Void) {
        doneHandler = handler
    }
    
    func appendTodoList(item: ListItem) {
        totalListItems[0].append(item)
    }
    
    func fetch(targetItem: ListItem, from type: ListType) -> (ListItem?, Int?) {
        var resultItem: ListItem?
        var resultIndex: Int?
        
        totalListItems[type.rawValue].enumerated().forEach { (index, item) in
            guard targetItem.id == item.id else { return }
            
            resultItem = item
            resultIndex = index
        }
        
        return (resultItem, resultIndex)
    }
    
    func move(targetItem: ListItem, from currentType: ListType, to newType: ListType) {
        let result = fetch(targetItem: targetItem, from: currentType)
        
        guard let item = result.0,
              let index = result.1
        else {
            return
        }
            
        totalListItems[currentType.rawValue].remove(at: index)
        totalListItems[newType.rawValue].append(item)
    }
    
    func delete(at index: Int, type: ListType) {
        totalListItems[type.rawValue].remove(at: index)
    }
    
    func editItem(of type: ListType, at index: Int, title: String, body: String, dueDate: Date) {
        totalListItems[type.rawValue][index].title = title
        totalListItems[type.rawValue][index].body = body
        totalListItems[type.rawValue][index].dueDate = dueDate
    }
}
