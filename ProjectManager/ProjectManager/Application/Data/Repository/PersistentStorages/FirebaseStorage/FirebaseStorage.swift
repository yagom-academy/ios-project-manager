//
//  FirebaseStorage.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/22.
//

import UIKit
import FirebaseDatabase

class FirebaseStorage: RemoteStorageProtocol {
    private var databaseManager: DatabaseReference?

    init() {
        databaseManager = Database.database().reference()
    }

    func backupCardModel(_ model: CardModel) {
        databaseManager?
            .child("/cardModel/" + model.id)
            .setValue([
                "id": model.id,
                "title": model.title,
                "description": model.description,
                "deadlineDate": model.deadlineDate.description,
                "cardType": model.cardType.rawValue])
    }

    func backupCardHistoryModel(_ model: CardHistoryModel) {
        databaseManager?
            .child("/cardHistory/" + model.id)
            .setValue([
                "id": model.id,
                "title": model.title,
                "cardTypeDescription": model.cardTypeDescription,
                "date": model.date,
                "cardState": model.cardState])
    }

    func fetchCardModel() async throws -> [CardModel] {
        let snapshot = try await databaseManager?.getData()
        guard let data = snapshot?.value as? [String: [String: Any]] else { throw FetchError.emptyData }

        let cardlist = data.map { CardRemoteDataEntity(entity: $1).generate() }
        return cardlist
    }

    func fetchCardHistoryModel() async throws -> [CardHistoryModel] {
        let snapshot = try await databaseManager?.getData()
        guard let data = snapshot?.value as? [String: [String: Any]] else { throw FetchError.emptyData }

        let cardHistorylist = data.map { CardHistoryDataEntity(value: $1).generate() }
        return cardHistorylist
    }

    func delete(_ model: CardModel) {
        databaseManager?.child(model.id).removeValue()
    }
}
