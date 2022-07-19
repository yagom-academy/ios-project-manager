//
//  DefaultCardRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

final class DefaultCardRepository: CardRepository {
  private let service: CardCoreDataService
  
  init(service: CardCoreDataService) {
    self.service = service
  }
  
  func createCard(_ card: Card) {
    service.create(card: card)
  }
  
  func fetchCard(id: String) -> Card? {
    guard let object = service.fetchOne(id: id) else { return nil }
    return object.toDomain()
  }
  
  func fetchCards() -> [Card] {
    return service.fetchAll().map { $0.toDomain() }
  }
  
  func updateCard(_ card: Card) {
    service.update(card: card)
  }
  
  func deleteCard(_ card: Card) {
    service.delete(id: card.id)
  }
}
