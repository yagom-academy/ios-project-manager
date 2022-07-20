//
//  DefaultCardRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import RxSwift

final class DefaultCardRepository: CardRepository {
  private let service: CardCoreDataService
  
  init(service: CardCoreDataService) {
    self.service = service
  }
  
  func createCard(_ card: Card) -> Observable<Never> {
    return service.create(card: card)
  }
  
  func fetchCard(id: String) -> Observable<Card> {
    return service.fetchOne(id: id)
      .map { $0.toDomain() }
  }
  
  func fetchCards() -> Observable<[Card]> {
    return service.fetchAll()
      .map { $0.map { $0.toDomain() } }
  }
  
  func updateCard(_ card: Card) -> Observable<Never> {
    return service.update(card: card)
  }
  
  func deleteCard(_ card: Card) -> Observable<Never> {
    return service.delete(id: card.id)
  }
}
