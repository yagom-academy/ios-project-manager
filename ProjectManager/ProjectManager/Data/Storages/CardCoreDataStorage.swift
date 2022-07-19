//
//  CardCoreDataStorage.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import CoreData

protocol CardCoreDataStoragable {
  func create(card: Card)
  func fetchOne(id: String) -> Card?
  func fetchAll() -> [Card]
  func update(card: Card)
  func delete(id: String)
}

final class CardCoreDataStorage: CardCoreDataStoragable {
  private enum Settings {
    static let CardEntityName = "CardEntity"
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
  
  private func _fetch(id: String) -> CardEntity? {
    let request = CardEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id = %@", id)
    
    if let entity = try? storage.context.fetch(request).first {
      return entity
    }
    return nil
  }
  
  func fetchOne(id: String) -> Card? {
    guard let object = _fetch(id: id) else { return nil }
    
    return object.toDomain()
  }
  
  func fetchAll() -> [Card] {
    guard let objects = try? storage.context.fetch(CardEntity.fetchRequest()) else { return [] }
    
    return objects.map { $0.toDomain() }
  }
  
  func update(card: Card) {
    guard let object = _fetch(id: card.id) else { return }
    
    object.setValue(card.title, forKey: "title")
    object.setValue(card.description, forKey: "body")
    object.setValue(card.deadlineDate, forKey: "deadlineDate")
    object.setValue(card.cardType.rawValue, forKey: "cardType")
    
    storage.saveContext()
  }
  
  func delete(id: String) {
    guard let entity = _fetch(id: id) else { return }
    
    storage.context.delete(entity)
    storage.saveContext()
  }
}

// MARK: - Mapping

extension CardEntity {
  func toDomain() -> Card {
    return Card(
      id: id ?? UUID().uuidString,
      title: title ?? "",
      description: body ?? "",
      deadlineDate: deadlineDate ?? Date(),
      cardType: CardType(rawValue: cardType) ?? .todo
    )
  }
}
