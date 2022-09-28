//
//  RealmStorage.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/22.
//

import UIKit
import RealmSwift

final class RealmStorage: LocalStorageProtocol {
    private var realmManager: Realm?

    init() {
        realmManager = try? Realm()
    }

    func saveCardModel(_ model: CardModel) throws {
        let entity = CardLocalDataEntity(id: model.id,
                                         title: model.title,
                                         description: model.description,
                                         deadlineDate: model.deadlineDate,
                                         cardType: model.cardType)
        do {
            try realmManager?.write {
                realmManager?.add(entity)
            }
        } catch {
            throw error
        }
    }

    func saveHistoryModel(_ model: CardHistoryModel) throws {
        let entity = CardHistoryDataEntity(id: UUID().uuidString,
                                           title: model.title,
                                           date: model.date,
                                           cardTypeDescription: model.cardTypeDescription,
                                           cardState: model.cardState.rawValue)
        do {
            try realmManager?.write {
                realmManager?.add(entity)
            }
        } catch {
            throw error
        }
    }

    func fetchCardModel() -> [CardModel] {
        guard let data = realmManager?.objects(CardLocalDataEntity.self) else { return [] }
        let model = data.map({ $0.generate() }) ?? []
        return model
    }

    func fetchCardHistoryModel() -> [CardHistoryModel] {
        guard let data = realmManager?.objects(CardHistoryDataEntity.self) else { return [] }
        let model = data.map({ $0.generate() }) ?? []
        return model
    }

    func update(_ newModel: CardModel) throws {
        do {
            guard let entity = realmManager?
                .objects(CardLocalDataEntity.self)
                .filter(NSPredicate(format: "id = %@",
                                    newModel.id as CVarArg)).first else { return }
            try realmManager?.write {
                entity.update(newModel)
            }
        } catch {
            throw error
        }
    }

    func delete(_ model: CardModel) throws {
        do {
            guard let entity = realmManager?
                .objects(CardLocalDataEntity.self)
                .filter(NSPredicate(format: "id = %@",
                                    model.id as CVarArg)).first else { return }

            try realmManager?.write {
                realmManager?.delete(entity)
            }
        } catch {
            throw error
        }
    }
}
