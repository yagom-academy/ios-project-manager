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
      .catchAndReturn([])
      .withUnretained(self)
      .flatMap { wself, cards -> Observable<[Card]> in
        wself.cards.accept(cards)
        wself.cardNotificationService.removeCardsNotification(cards)
        return wself.realtimeDatabaseRepository.fetchAll()
      }
      .catchAndReturn([])
      .withUnretained(self)
      .flatMap { wself, cards -> Observable<Void> in
        wself.cards.accept(cards)
        wself.cardNotificationService.registerCardsNotification(cards)
        return .concat(
          wself.localDatabaseRepository.deleteAll(),
          wself.localDatabaseRepository.create(cards).map { _ in }
        )
      }
      .catchAndReturn(())
  }
  
  func createNewCard(_ card: Card) -> Observable<Void> {
    return localDatabaseRepository.create(card)
      .map { History(card: card, actionType: .create, actionTime: Date()) }
      .withUnretained(self)
      .flatMap { wself, history -> Observable<[Card]> in
        wself.histories.accept(wself.histories.value + [history])
        return wself.localDatabaseRepository.fetchAll()
      }
      .flatMap(realtimeDatabaseRepository.create(_:))
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        self?.cardNotificationService.registerCardNotification(card)
        return .just(())
      }
  }
  
  func updateSelectedCard(_ card: Card) -> Observable<Void> {
    return localDatabaseRepository.update(card)
      .map { History(card: card, actionType: .update, actionTime: Date()) }
      .withUnretained(self)
      .flatMap { wself, history -> Observable<[Card]> in
        wself.histories.accept(wself.histories.value + [history])
        return wself.localDatabaseRepository.fetchAll()
      }
      .flatMap(realtimeDatabaseRepository.create(_:))
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        self?.cardNotificationService.updateCardNotification(card)
        return .just(())
      }
  }
  
  func deleteSelectedCard(_ card: Card) -> Observable<Void> {
    return localDatabaseRepository.delete(card)
      .map { History(card: card, actionType: .delete, actionTime: Date()) }
      .withUnretained(self)
      .flatMap { wself, history -> Observable<[Card]> in
        wself.histories.accept(wself.histories.value + [history])
        return wself.localDatabaseRepository.fetchAll()
      }
      .flatMap(realtimeDatabaseRepository.create(_:))
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        self?.cardNotificationService.removeCardNotification(card)
        return .just(())
      }
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void> {
    var newCard = card
    newCard.cardType = card.cardType.distinguishMenuType[index]
    
    return localDatabaseRepository.update(newCard)
      .map { History(card: card, actionType: .move(newCard.cardType), actionTime: Date()) }
      .withUnretained(self)
      .flatMap { wself, history -> Observable<[Card]> in
        wself.histories.accept(wself.histories.value + [history])
        return wself.localDatabaseRepository.fetchAll()
      }
      .flatMap(realtimeDatabaseRepository.create(_:))
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        self?.cardNotificationService.updateCardNotification(newCard)
        return .just(())
      }
  }
}
