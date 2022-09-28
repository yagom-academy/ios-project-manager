//
//  RepositoryService.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/27.
//

import Foundation

final class RepositoryService {
    static let shared = RepositoryService()
    private let realmService: LocalStorageProtocol = RealmStorage()
    private let firebaseService: RemoteStorageProtocol = FirebaseStorage()

    private init() {
        synchronizeData()
    }

    private func synchronizeData() {
        let localData = self.realmService.fetchCardModel()
        Task {
            let romoteData = try await firebaseService.fetchCardModel()
            self.combine(between: localData,
                         and: romoteData)
        }
    }

    private func combine(between localData: [CardModel],
                         and remoteData: [CardModel]) {
        guard haveDifferentData(with: localData, remoteData) else { return }

        for remoteDatum in remoteData {
            saveDifferentData(between: localData,
                              and: remoteDatum)
        }
    }

    private func haveDifferentData(with localData: [CardModel],
                                   _ remoteData: [CardModel]) -> Bool {
        if localData.count < remoteData.count {
            return true
        }
        return false
    }

    private func saveDifferentData(between localData: [CardModel], and remoteDatum: CardModel) {
        for localDatum in localData where localDatum != remoteDatum {
            try? self.realmService.saveCardModel(localDatum)
        }
    }

    func fetchCardModel() -> [CardModel] {
        return realmService.fetchCardModel()
    }

    func fetchCardHistoryModel() -> [CardHistoryModel] {
        let data = realmService.fetchCardHistoryModel()

        return data
    }

    func save(_ newCard: CardModel) throws {
        do {
            try realmService.saveCardModel(newCard)
            try realmService.saveHistoryModel(CardHistoryModel(id: newCard.id,
                                                               title: newCard.title,
                                                               date: newCard.deadlineDate,
                                                               cardTypeDescription: "",
                                                               cardState: .added))
        } catch {
            throw error
        }
        firebaseService.backupCardModel(newCard)
    }

    func update(_ selectedCard: CardModel) throws {
        do {
            try realmService.update(selectedCard)
        } catch {
            throw error
        }
        firebaseService.backupCardModel(selectedCard)
        
    }

    func saveHistory(_ card: CardModel) throws {
        try realmService.saveHistoryModel(CardHistoryModel(id: card.id,
                                                           title: card.title,
                                                           date: Date(),
                                                           cardTypeDescription: card.cardType.moveToAnotherSection,
                                                           cardState: .moved))
    }

    func delete(_ card: CardModel) throws {
        do {
            try realmService.saveHistoryModel(CardHistoryModel(id: card.id,
                                                               title: card.title,
                                                               date: Date(),
                                                               cardTypeDescription: card.cardType.rawValue,
                                                               cardState: .removed))
            try realmService.delete(card)
        } catch {
            throw error
        }

        firebaseService.delete(card)
    }
}
