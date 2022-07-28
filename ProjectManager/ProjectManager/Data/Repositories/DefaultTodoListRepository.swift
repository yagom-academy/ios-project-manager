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
    private enum Constant {
        static let userStateKey = "isUser"
    }
    
    private unowned let storage: TodoListStorage
    private unowned let backUpStorage: RemoteBackUpStorage
    private let bag = DisposeBag()
    private unowned let userStateStorage: UserDefaults
    
    private var isUser: Bool {
        if userStateStorage.bool(forKey: Constant.userStateKey) {
            return true
        } else {
            userStateStorage.set(true, forKey: Constant.userStateKey)
            return false
        }
    }
    
    init(storage: TodoListStorage, backUpStorage: RemoteBackUpStorage, userStateStorage: UserDefaults) {
        self.storage = storage
        self.backUpStorage = backUpStorage
        self.userStateStorage = userStateStorage
        upLoad()
        backUp()
    }
    
    private func upLoad() {
        if isUser == false {
            backUpStorage.readAll()
                .subscribe { [weak self] items in
                    items.forEach { [weak self] item in
                        self?.storage.create(to: item)
                    }
                } onFailure: { [weak self] _ in
                    self?.storage.errorObserver.accept(TodoError.backUpError)
                }.disposed(by: bag)
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
    
    func create(to data: TodoModel) {
        storage.create(to: data)
    }
    
    func update(to data: TodoModel) {
        storage.update(to: data)
    }
    
    func delete(index: Int) {
        storage.delete(index: index)
    }
}
