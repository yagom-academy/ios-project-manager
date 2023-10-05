//
//  RealmHistoryRepository.swift
//  ProjectManager
//
//  Created by 김민성 on 2023/10/04.
//

import Foundation
import RealmSwift

final class HistoryRealmRepository: HistoryRepository {
    
    private let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("could not load REALM")
        }
    }()
    
    func fetchAll() -> [History] {
        let historyObjects = realm.objects(HistoryObject.self).sorted(by: \.date, ascending: false)
        let historyList = Array(historyObjects).map { $0.toDomain() }
        
        return historyList
    }
    
    func save(_ history: History) {
        try? realm.write {
            realm.add(history.toObject())
        }
    }
}

