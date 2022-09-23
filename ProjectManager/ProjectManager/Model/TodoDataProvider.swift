//
//  TodoDataProvider.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/16.
//

import RxSwift
import FirebaseFirestore

final class TodoDataProvider {
    
    // MARK: - Properties
    
    static let shared = TodoDataProvider()
    
    var allTodoList = BehaviorSubject<[Todo]>(value: [])
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    private init() {
        fetchTodoData()
    }
    
    // MARK: - Methods
    
    func saveTodoData(document: String, todoData: Todo) {
        FirebaseManager.shared.sendData(
            collection: "todo_list",
            document: document,
            data: todoData
        )
        .subscribe(onError: { error in
        }, onCompleted: {
            self.fetchTodoData()
        })
        .disposed(by: self.disposeBag)
    }
    
    func deleteTodoData(document: String) {
        FirebaseManager.shared.deleteTodoData(
            collection: "todo_list",
            document: document
        )
        .subscribe(onError: { error in
        }, onCompleted: {
            self.fetchTodoData()
        })
        .disposed(by: self.disposeBag)
        
    }
    
    func fetchTodoData() {
        FirebaseManager.shared.fetchData(collection: "todo_list")
            .map { self.convertData($0) }
            .map { $0.sorted { $0.createdAt < $1.createdAt } }
            .take(1)
            .subscribe(onNext: { todoList in
                self.allTodoList.onNext(todoList)
            })
            .disposed(by: disposeBag)
    }
    
    private func convertData(_ firebaseSnapshot: [QueryDocumentSnapshot]) -> [Todo] {
        var convertedTodoList: [Todo] = []
        
        firebaseSnapshot.forEach { documents in
            guard let todo = Todo(dictionary: documents.data()) else { return }
            convertedTodoList.append(todo)
        }
        
        return convertedTodoList
    }
}
