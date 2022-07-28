//
//  DefaultCardUseCase.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/18.
//

import Foundation

import RxRelay
import RxSwift

protocol CardUseCase: AnyObject {
  var cards: BehaviorRelay<[Card]> { get }
  var histories: BehaviorRelay<[History]> { get }
  var undoHistories: BehaviorRelay<[History]> { get }
  var redoHistories: BehaviorRelay<[History]> { get }
  
  func fetchCards() -> Observable<Void>
  func createNewCard(_ card: Card) -> Observable<Void>
  func updateSelectedCard(_ card: Card) -> Observable<Void>
  func deleteSelectedCard(_ card: Card) -> Observable<Void>
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void>
}

// MARK: - Implement

final class DefaultCardUseCase: CardUseCase {
  private enum Settings {
    static let firstTimeRunningCheckingKey = "IsAppRunningFirstTime"
  }
  
  private let localDatabaseRepository: LocalDatabaseRepository
  private let realtimeDatabaseRepository: RealtimeDatabaseRepository
  private let cardNotificationService: CardNotificationService
  
  let cards = BehaviorRelay<[Card]>(value: [])
  let histories = BehaviorRelay<[History]>(value: [])
  let undoHistories = BehaviorRelay<[History]>(value: [])
  let redoHistories = BehaviorRelay<[History]>(value: [])
  
  init(
    localDatabaseRepository: LocalDatabaseRepository,
    realtimeDatabaseRepository: RealtimeDatabaseRepository,
    cardNotificationService: CardNotificationService
  ) {
    self.localDatabaseRepository = localDatabaseRepository
    self.realtimeDatabaseRepository = realtimeDatabaseRepository
    self.cardNotificationService = cardNotificationService
  }
  
  func fetchCards() -> Observable<Void> {
    return localDatabaseRepository.fetchAll()
      .withUnretained(self)
      .flatMap { owner, cards -> Observable<[Card]> in
        owner.cards.accept(cards)
        return owner.realtimeDatabaseRepository.fetchAll()
      }
      .withUnretained(self)
      .flatMap { owner, cards -> Observable<Void> in
        owner.cards.accept(cards)
        owner.cardNotificationService.registerCardsNotification(cards)
        return .concat(
          owner.localDatabaseRepository.deleteAll(),
          owner.localDatabaseRepository.create(cards).map { _ in }
        )
      }
      .catchAndReturn(())
  }
  
  func createNewCard(_ card: Card) -> Observable<Void> {
    return Observable.just(card)
      .map { History(prev: $0, next: $0, actionType: .create) }
      .withUnretained(self)
      .flatMap { owner, history -> Observable<Void> in
        owner.histories.accept(owner.histories.value + [history])
        owner.cardNotificationService.removeCardNotification(card)
        
        // TODO: Undo Redo 등록
        return owner.localDatabaseRepository.create(card)
      }
      .flatMap(localDatabaseRepository.fetchAll)
      .flatMap(realtimeDatabaseRepository.create)
      .map { [weak self] in self?.cards.accept($0) }
  }
  
  func updateSelectedCard(_ card: Card) -> Observable<Void> {
    return localDatabaseRepository.fetchOne(id: card.id)
      .map { History(prev: $0, next: card, actionType: .update) }
      .withUnretained(self)
      .flatMap { owner, history -> Observable<Void> in
        owner.histories.accept(owner.histories.value + [history])
        owner.cardNotificationService.registerCardNotification(card)
        
        // TODO: Undo Redo 등록
        return owner.localDatabaseRepository.update(card)
      }
      .flatMap(localDatabaseRepository.fetchAll)
      .flatMap(realtimeDatabaseRepository.create)
      .map { [weak self] in self?.cards.accept($0) }
  }
  
  func deleteSelectedCard(_ card: Card) -> Observable<Void> {
    return Observable.just(card)
      .map { History(prev: $0, next: nil, actionType: .delete) }
      .withUnretained(self)
      .flatMap { owner, history -> Observable<Void> in
        owner.histories.accept(owner.histories.value + [history])
        owner.cardNotificationService.removeCardNotification(card)
        
        // TODO: Undo Redo 등록
        return owner.localDatabaseRepository.delete(card)
      }
      .flatMap(localDatabaseRepository.fetchAll)
      .flatMap(realtimeDatabaseRepository.create)
      .map { [weak self] in self?.cards.accept($0) }
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void> {
    return Observable.just(card)
      .map { oldCard -> History in
        var newCard = oldCard
        newCard.cardType = oldCard.cardType.distinguishMenuType[index]
        return History(prev: oldCard, next: newCard, actionType: .move(newCard.cardType))
      }
      .withUnretained(self)
      .flatMap { owner, history -> Observable<Void> in
        let newCard = history.next ?? .empty()
        owner.histories.accept(owner.histories.value + [history])
        owner.cardNotificationService.registerCardNotification(newCard)
        
        // TODO: Undo Redo 등록
        return owner.localDatabaseRepository.update(newCard)
      }
      .flatMap(localDatabaseRepository.fetchAll)
      .flatMap(realtimeDatabaseRepository.create)
      .map { [weak self] in self?.cards.accept($0) }
  }
}
