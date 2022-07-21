//
//  DefaultCardRepository.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/19.
//

import Foundation

import RxSwift

final class DefaultCardRepository: CardRepository {
  private enum Settings {
    static let firstTimeRunningCheckingKey = "IsAppRunningFirstTime"
  }
  
  private let localCoreDataService: CardCoreDataService
  private let realtimeDatabaseService: RealtimeDatabaseService
  
  init(
    localCoreDataService: CardCoreDataService,
    realtimeDatabaseService: RealtimeDatabaseService
  ) {
    self.localCoreDataService = localCoreDataService
    self.realtimeDatabaseService = realtimeDatabaseService
  }
  
  func createCard(_ card: Card) -> Observable<Void> {
    return localCoreDataService.create(card: card)
  }
  
  func fetchCard(id: String) -> Observable<Card> {
    return localCoreDataService.fetchOne(id: id)
      .map { $0.toDomain() }
  }
  
  func fetchCards() -> Observable<[Card]> {
    if UserDefaults.standard.object(forKey: Settings.firstTimeRunningCheckingKey) == nil {
      UserDefaults.standard.set(false, forKey: Settings.firstTimeRunningCheckingKey)
      
      return realtimeDatabaseService.fetch()
        .catchAndReturn([])
        .withUnretained(self)
        .flatMap { wself, cards in wself.localCoreDataService.create(cards: cards) }
    }
    
    return localCoreDataService.fetchAll()
      .map { $0.map { $0.toDomain() } }
      .withUnretained(self)
      .flatMap { wself, cards in wself.realtimeDatabaseService.write(cards: cards) }
  }
  
  func updateCard(_ card: Card) -> Observable<Void> {
    return localCoreDataService.update(card: card)
  }
  
  func deleteCard(_ card: Card) -> Observable<Void> {
    return localCoreDataService.delete(id: card.id)
  }
}
