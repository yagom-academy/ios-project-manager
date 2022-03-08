//
//  TaskCellViewModel.swift
//  ProjectManager
//
//  Created by 서녕 on 2022/03/04.
//

import Foundation

class ToDoViewModel {
    let dataManager = TestDataManager()
    var todoOnUpdated: (() -> Void) = {}
    var todos = [ToDoInfomation]() {
        didSet {
            todos = todos.sorted { $0.deadline > $1.deadline }
            todoOnUpdated()
        }
    }
        
    func save(with todo: ToDoInfomation) {
        dataManager.save(with: todo)
        self.reload()
    }
    
    func delete(with todo: ToDoInfomation) {
        dataManager.delete(with: todo)
        self.reload()
    }
    
    func changePosition(
        from berforePosition: ToDoPosition,
        to afterPosition: ToDoPosition,
        currentIndexPath: Int
    ) {
        let beforePositionList = todos.filter{ $0.position == berforePosition }
        let targetId = beforePositionList[currentIndexPath].id
        dataManager.changePosition(
            to: afterPosition,
            target: targetId
        )
        self.reload()
    }
    
    func reload() {
        dataManager.fetch { [weak self] todoList in
            guard let self = self else {
                return
            }
            self.todos = todoList
        }
    }
}
