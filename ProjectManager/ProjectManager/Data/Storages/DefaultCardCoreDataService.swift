//
//  DefaultCardCoreDataService.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

protocol CardCoreDataService {
  func create(card: Card)
  func fetchOne(id: String) -> CardEntity?
  func fetchAll() -> [CardEntity]
  func update(card: Card)
  func delete(id: String)
}

final class DefaultCardCoreDataService: CardCoreDataService {
  private enum Settings {
    static let CardEntityName = "CardEntity"
    static let deleteAllFailureMessage = "전체 삭제에 실패했습니다."
  }
  
  private let storage: CoreDataStorage
  
  init(storage: CoreDataStorage = .shared) {
    self.storage = storage
  }
  
  func create(card: Card) {
    guard let entity = NSEntityDescription.entity(
      forEntityName: Settings.CardEntityName,
      in: storage.context) else { return }
    
    let object = NSManagedObject(entity: entity, insertInto: storage.context)
    object.setValue(card.id, forKey: "id")
    object.setValue(card.title, forKey: "title")
    object.setValue(card.description, forKey: "body")
    object.setValue(card.deadlineDate, forKey: "deadlineDate")
    object.setValue(card.cardType.rawValue, forKey: "cardType")
    
    storage.saveContext()
  }
  
  func fetchOne(id: String) -> CardEntity? {
    let request = CardEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    
    guard let object = try? storage.context.fetch(request).first else { return nil }
    return object
  }
  
  func fetchAll() -> [CardEntity] {
    guard let objects = try? storage.context.fetch(CardEntity.fetchRequest()) else { return [] }
    return objects
  }
  
  func update(card: Card) {
    guard let object = fetchOne(id: card.id) else { return }
    
    object.setValue(card.title, forKey: "title")
    object.setValue(card.description, forKey: "body")
    object.setValue(card.deadlineDate, forKey: "deadlineDate")
    object.setValue(card.cardType.rawValue, forKey: "cardType")
    
    storage.saveContext()
  }
  
  func delete(id: String) {
    guard let entity = fetchOne(id: id) else { return }
    
    storage.context.delete(entity)
    storage.saveContext()
  }
  
  func deleteAll() {
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: CardEntity.fetchRequest())
    do {
      try storage.context.execute(deleteRequest)
    } catch {
      assertionFailure(Settings.deleteAllFailureMessage)
    }
  }
  
  func count() -> Int {
    return fetchAll().count
  }
}
