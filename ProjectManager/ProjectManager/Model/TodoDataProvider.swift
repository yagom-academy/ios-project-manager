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
    
    func saveTodoData(document: UUID, todoData: Todo) {
        FirebaseManager.shared.sendData(
            collection: "todo_list",
            document: document.uuidString,
            data: todoData
        )
        .subscribe(onError: { error in
        }, onCompleted: { [weak self] in
            self?.fetchTodoData()
        })
        .disposed(by: disposeBag)
    }
    
    func deleteTodoData(document: UUID) {
        FirebaseManager.shared.deleteTodoData(
            collection: "todo_list",
            document: document.uuidString
        )
        .subscribe(onError: { error in
        }, onCompleted: { [weak self] in
            self?.fetchTodoData()
        })
        .disposed(by: disposeBag)
    }
    
    func fetchTodoData() {
        FirebaseManager.shared.fetchData(collection: "todo_list")
            .map { self.convertData($0) }
            .map { $0.sorted { $0.createdAt < $1.createdAt } }
            .take(1)
            .subscribe(onNext: { [weak self] todoList in
                self?.allTodoList.onNext(todoList)
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
