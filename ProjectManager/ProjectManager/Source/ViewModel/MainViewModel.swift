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
    
    func move(targetItem: ListItem, from currentType: ListType, to newType: ListType) {
        totalListItems[currentType.rawValue].enumerated().forEach { (index, item) in
            guard targetItem.id == item.id else { return }
            
            totalListItems[currentType.rawValue].remove(at: index)
            totalListItems[newType.rawValue].append(item)
        }
    }
}
