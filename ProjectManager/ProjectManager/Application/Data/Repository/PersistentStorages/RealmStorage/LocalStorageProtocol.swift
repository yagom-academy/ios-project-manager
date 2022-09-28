//
//  LocalStorageProtocol.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/22.
//

protocol LocalStorageProtocol {
    func saveCardModel(_ model: CardModel) throws
    func saveHistoryModel(_ model: CardHistoryModel) throws
    func fetchCardModel() -> [CardModel]
    func fetchCardHistoryModel() -> [CardHistoryModel]
    func update(_ newModel: CardModel) throws
    func delete(_ model: CardModel) throws 
}
