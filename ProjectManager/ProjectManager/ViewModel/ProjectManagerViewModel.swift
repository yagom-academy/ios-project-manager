//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import Foundation
import RxSwift

class ProjectManagerViewModel {
    
    // MARK: - Properties
    
    private var allTodoList = BehaviorSubject<[Todo]>(value: [])
    var categorizedTodoList: [TodoStatus: Observable<[Todo]>] = [:]
    
    // MARK: - Life Cycle
    
    init() {
        let sampleData = Todo.generateSampleData(
            count: 20,
            maxBodyLine: 10,
            startDate: "2022-09-01",
            endData: "2022-09-30"
        )
        allTodoList.onNext(sampleData)
        
        TodoStatus.allCases.forEach { status in
            categorizedTodoList[status] = categorizeTodoList(by: status)
        }
    }
}

// MARK: - Categorizer Methods

extension ProjectManagerViewModel {
    private func categorizeTodoList(by status: TodoStatus) -> Observable<[Todo]> {
        let categorizedTodoList = allTodoList
            .map { todoList -> [Todo] in
                self.categorizeTodoList(whether: status, todoList: todoList)
            }
            .map { todoList -> [Todo] in
                self.checkOutdated(of: todoList)
            }
        
        return categorizedTodoList
    }
    
    private func categorizeTodoList(whether status: TodoStatus, todoList: [Todo]) -> [Todo] {
        return todoList.filter { todo in
            todo.status == status
        }
    }
    
    private func checkOutdated(of todoList: [Todo]) -> [Todo] {
        return todoList.map { todo -> Todo in
            if todo.createdAt < Date() {
                var outDatedTodo: Todo = todo
                outDatedTodo.isOutdated = true
                return outDatedTodo
            }
            
            return todo
        }
    }
}
