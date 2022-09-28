//
//  RemoteStorageProtocol.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/25.
//

protocol RemoteStorageProtocol {
    func backupCardModel(_ model: CardModel)
    func backupCardHistoryModel(_ model: CardHistoryModel)
    func fetchCardModel() async throws -> [CardModel]
    func fetchCardHistoryModel() async throws -> [CardHistoryModel]
    func delete(_ model: CardModel)
}
