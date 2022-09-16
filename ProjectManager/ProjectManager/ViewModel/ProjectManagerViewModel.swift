//
//  ProjectManagerViewModel.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import FirebaseFirestore
import RxSwift

class ProjectManagerViewModel {
    
    // MARK: - Properties
    
    static let firestoreCollectionName = "todo_list"
    
//    var provider: DataProvider
    
    var allTodoList = BehaviorSubject<[Todo]>(value: [])
    var categorizedTodoList: [TodoStatus: Observable<[Todo]>] = [:]
    
    var saveTodoData: PublishSubject<Todo>?
    var deleteTodoData: PublishSubject<Todo>?
    var changeStatusTodoData: PublishSubject<(TodoStatus, Int, TodoStatus)>?
    
    var alertError = PublishSubject<Error>()
    
    var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    init() {
        configureSaveTodoData()
        configureDeleteTodoData()
        configureChangeStatusTodoData()
        configureCategorizedTodoList()
        
        fetchTodoData()
    }
    
    deinit {
        disposeBag = DisposeBag()
    }
}

// MARK: - Configure Methods

extension ProjectManagerViewModel {
    private func configureCategorizedTodoList() {
        TodoStatus.allCases.forEach { status in
            categorizedTodoList[status] = categorizeTodoList(by: status)
        }
    }
    
    private func configureSaveTodoData() {
        saveTodoData = PublishSubject<Todo>()
        
        saveTodoData?
            .subscribe(onNext: { todoData in
                self.requestSave(using: todoData)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureDeleteTodoData() {
        deleteTodoData = PublishSubject<Todo>()
        
        deleteTodoData?
            .subscribe(onNext: { todoData in
                self.requestDelete(using: todoData)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureChangeStatusTodoData() {
        changeStatusTodoData = PublishSubject<(TodoStatus, Int, TodoStatus)>()
        
        changeStatusTodoData?
            .subscribe(onNext: { (currentStatus, indexPathRow, destinationStatus) in
                self.requestChangeStatus(currentStatus, indexPathRow, destinationStatus)
            })
            .disposed(by: disposeBag)
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
}

// MARK: - Request Methods

extension ProjectManagerViewModel {
    private func requestSave(using todoData: Todo) {
            guard todoData.title.isEmpty == false else {
                alertError.onNext(TodoError.emptyTitle)
                return
            }
            
            FirebaseManager.shared.sendData(
                collection: ProjectManagerViewModel.firestoreCollectionName,
                document: todoData.todoId.uuidString,
                data: todoData
            )
            .take(1)
            .subscribe(onError: { error in
                self.alertError.onNext(error)
            }, onCompleted: {
                self.saveTodoData?.onCompleted()
                self.configureSaveTodoData()
                self.fetchTodoData()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func requestDelete(using todoData: Todo) {
        FirebaseManager.shared.deleteTodoData(collection: ProjectManagerViewModel.firestoreCollectionName, document: todoData.todoId.uuidString)
            .subscribe(onError: { error in
                self.alertError.onNext(error)
            }, onCompleted: {
                self.deleteTodoData?.onCompleted()
                self.configureDeleteTodoData()
                self.fetchTodoData()
            })
            .disposed(by: disposeBag)
    }
    
    private func requestChangeStatus(_ currentStatus: TodoStatus, _ indexPathRow: Int, _ destinationStatus: TodoStatus) {
        self.categorizedTodoList[currentStatus]?
            .take(1)
            .subscribe(onNext: { todoData in
                var changedTodo = todoData[indexPathRow]
                changedTodo.status = destinationStatus
                self.saveTodoData?
                    .subscribe(onCompleted: {
                        self.changeStatusTodoData?.onCompleted()
                        self.configureChangeStatusTodoData()
                    })
                .disposed(by: self.disposeBag)
                
                self.requestSave(using: changedTodo)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Other Methods

extension ProjectManagerViewModel {
    private func fetchTodoData() {
        FirebaseManager.shared.fetchData(collection: ProjectManagerViewModel.firestoreCollectionName)
            .map { self.convertData($0) }
            .map { $0.sorted { $0.createdAt < $1.createdAt } }
            .take(1)
            .subscribe(onNext: { todoList in
                self.allTodoList.onNext(todoList)
            })
            .disposed(by: disposeBag)
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
    
    private func convertData(_ firebaseSnapshot: [QueryDocumentSnapshot]) -> [Todo] {
        var convertedTodoList: [Todo] = []
        
        firebaseSnapshot.forEach { documents in
            guard let todo = Todo(dictionary: documents.data()) else { return }
            convertedTodoList.append(todo)
        }
        
        return convertedTodoList
    }
}
