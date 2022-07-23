//
//  DefaultTodoListRepository.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit
import RxSwift
import RxRelay

final class DefaultTodoListRepository {
    private unowned let storage: TodoListStorage
    private unowned let backUpStorage: RemoteBackUpStorage
    private let bag = DisposeBag()
    
    private var isUser: Bool {
        if UserDefaults.standard.bool(forKey: "isUser") {
            return true
        } else {
            UserDefaults.standard.set(true, forKey: "isUser")
            return false
        }
    }
    
    init(storage: TodoListStorage, backUpStorage: RemoteBackUpStorage) {
        self.storage = storage
        self.backUpStorage = backUpStorage
        upLoad()
        backUp()
    }
    
    private func upLoad() {
        guard isUser else {
            backUpStorage.allRead()
                .subscribe { [weak self] items in
                    items.forEach { [weak self] item in
                        self?.storage.save(to: item)
                    }
                } onFailure: { [weak self] _ in
                    self?.storage.errorObserver.accept(TodoError.backUpError)
                }.disposed(by: bag)
            return
        }
    }
    
    private func backUp() {
        NotificationCenter.default.rx.notification(UIApplication.didEnterBackgroundNotification)
            .bind { [weak self] _ in
                guard let items = try? self?.storage.read().value() else { return }
                self?.backUpStorage.backUp(items: items)
            }.disposed(by: bag)
    }
}

extension DefaultTodoListRepository: TodoListRepository {
    var errorObserver: PublishRelay<TodoError> {
        return storage.errorObserver
    }
    
    func read() -> BehaviorSubject<[TodoModel]> {
        return storage.read()
    }
    
    func save(to data: TodoModel) {
        storage.save(to: data)
    }
    
    func delete(index: Int) {
        storage.delete(index: index)
    }
}
