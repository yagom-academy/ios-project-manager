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
  func undo() -> Observable<Void>
  func redo() -> Observable<Void>
}

// MARK: - Implement

final class DefaultCardUseCase: CardUseCase {
  private enum Settings {
    static let firstTimeRunningCheckingKey = "IsAppRunningFirstTime"
  }
  
  private let localDatabaseRepository: LocalDatabaseRepository
  private let realtimeDatabaseRepository: RealtimeDatabaseRepository
  private let cardNotificationService: CardNotificationService
  private let undoRedoService: UndoRedoService
  
  let cards = BehaviorRelay<[Card]>(value: [])
  let histories = BehaviorRelay<[History]>(value: [])
  let undoHistories = BehaviorRelay<[History]>(value: [])
  let redoHistories = BehaviorRelay<[History]>(value: [])
  
  init(
    localDatabaseRepository: LocalDatabaseRepository,
    realtimeDatabaseRepository: RealtimeDatabaseRepository,
    cardNotificationService: CardNotificationService,
    undoRedoService: UndoRedoService
  ) {
    self.localDatabaseRepository = localDatabaseRepository
    self.realtimeDatabaseRepository = realtimeDatabaseRepository
    self.cardNotificationService = cardNotificationService
    self.undoRedoService = undoRedoService
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
      .map { History(next: $0, actionType: .create) }
      .withUnretained(self)
      .flatMap { owner, history -> Observable<Void> in
        owner.histories.accept(owner.histories.value + [history])
        owner.cardNotificationService.removeCardNotification(card)
        
        owner.undoRedoService.take(history: history)
        owner.undoHistories.accept(owner.undoRedoService.undoStack)
        owner.redoHistories.accept(owner.undoRedoService.redoStack)
        
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
        
        owner.undoRedoService.take(history: history)
        owner.undoHistories.accept(owner.undoRedoService.undoStack)
        owner.redoHistories.accept(owner.undoRedoService.redoStack)
        
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
        
        owner.undoRedoService.take(history: history)
        owner.undoHistories.accept(owner.undoRedoService.undoStack)
        owner.redoHistories.accept(owner.undoRedoService.redoStack)
        
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
        
        owner.undoRedoService.take(history: history)
        owner.undoHistories.accept(owner.undoRedoService.undoStack)
        owner.redoHistories.accept(owner.undoRedoService.redoStack)
        
        return owner.localDatabaseRepository.update(newCard)
      }
      .flatMap(localDatabaseRepository.fetchAll)
      .flatMap(realtimeDatabaseRepository.create)
      .map { [weak self] in self?.cards.accept($0) }
  }
  
  func undo() -> Observable<Void> {
    let history = undoRedoService.undo()
    
    if let card = history?.prev {
      return localDatabaseRepository.isExist(id: card.id)
        .withUnretained(self)
        .flatMap { owner, isExist -> Observable<Void> in
          isExist
            ? owner.localDatabaseRepository.update(card)
            : owner.localDatabaseRepository.create(card)
        }
        .withUnretained(self)
        .flatMap { owner, _ -> Observable<[Card]> in
          owner.undoHistories.accept(owner.undoRedoService.undoStack)
          owner.redoHistories.accept(owner.undoRedoService.redoStack)
          return owner.localDatabaseRepository.fetchAll()
        }
        .flatMap(realtimeDatabaseRepository.create)
        .map { [weak self] in self?.cards.accept($0) }
      
    } else if let card = history?.next {
      return localDatabaseRepository.delete(card)
        .withUnretained(self)
        .flatMap { owner, _ -> Observable<[Card]> in
          owner.undoHistories.accept(owner.undoRedoService.undoStack)
          owner.redoHistories.accept(owner.undoRedoService.redoStack)
          return owner.localDatabaseRepository.fetchAll()
        }
        .flatMap(realtimeDatabaseRepository.create)
        .map { [weak self] in self?.cards.accept($0) }
    } else {
      return .empty()
    }
  }
  
  func redo() -> Observable<Void> {
    let history = undoRedoService.redo()
    
    if let card = history?.next {
      return localDatabaseRepository.isExist(id: card.id)
        .withUnretained(self)
        .flatMap { owner, isExist -> Observable<Void> in
          isExist
            ? owner.localDatabaseRepository.update(card)
            : owner.localDatabaseRepository.create(card)
        }
        .withUnretained(self)
        .flatMap { owner, _ -> Observable<[Card]> in
          owner.undoHistories.accept(owner.undoRedoService.undoStack)
          owner.redoHistories.accept(owner.undoRedoService.redoStack)
          return owner.localDatabaseRepository.fetchAll()
        }
        .flatMap(realtimeDatabaseRepository.create)
        .map { [weak self] in self?.cards.accept($0) }
      
    } else if let card = history?.prev {
      return Observable.just(card)
        .withUnretained(self)
        .flatMap { owner, card -> Observable<Void> in
          history?.actionType == .delete
            ? owner.localDatabaseRepository.delete(card)
            : owner.localDatabaseRepository.create(card)
        }
        .withUnretained(self)
        .flatMap { owner, _ -> Observable<[Card]> in
          owner.undoHistories.accept(owner.undoRedoService.undoStack)
          owner.redoHistories.accept(owner.undoRedoService.redoStack)
          return owner.localDatabaseRepository.fetchAll()
        }
        .flatMap(realtimeDatabaseRepository.create)
        .map { [weak self] in self?.cards.accept($0) }
    } else {
      return .empty()
    }
  }
}
