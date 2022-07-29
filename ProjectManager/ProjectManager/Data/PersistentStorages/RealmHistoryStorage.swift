//
//  RealmHistoryStorage.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation
import RxSwift
import RealmSwift
import RxRelay

protocol HistoryStorage: ErrorThrowble ,AnyObject {
    func read() -> BehaviorSubject<[History]>
    func save(to data: History)
}

final class RealmHistoryStorage {
    private let realm = try? Realm()
    
    private var storage: BehaviorSubject<[History]>
    private let items: Results<HistoryRealmEntity>?
    let errorObserver: PublishRelay<TodoError> = PublishRelay()

    init() {
        items = realm?.objects(HistoryRealmEntity.self)

        self.storage = .init(value: items?.map { $0.toHistory() } ?? [])
    }
}

extension RealmHistoryStorage: HistoryStorage {
    func read() -> BehaviorSubject<[History]> {
        return storage
    }
    
    func save(to data: History) {
        do {
            try realm?.write({
                guard let items = items else { return }
                realm?.add(HistoryRealmEntity(entity: data))
                
                storage.onNext(items.map { $0.toHistory() })
            })
        } catch {
            errorObserver.accept(TodoError.historySyncError)
        }
    }
}
