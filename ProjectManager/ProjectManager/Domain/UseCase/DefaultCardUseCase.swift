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
  
  let cards = BehaviorRelay<[Card]>(value: [])
  let histories = BehaviorRelay<[History]>(value: [])
  
  init(
    localDatabaseRepository: LocalDatabaseRepository,
    realtimeDatabaseRepository: RealtimeDatabaseRepository
  ) {
    self.localDatabaseRepository = localDatabaseRepository
    self.realtimeDatabaseRepository = realtimeDatabaseRepository
  }
  
  func fetchCards() -> Observable<Void> {
    if UserDefaults.standard.object(forKey: Settings.firstTimeRunningCheckingKey) == nil {
      UserDefaults.standard.set(false, forKey: Settings.firstTimeRunningCheckingKey)
      
      return realtimeDatabaseRepository.fetchAll()
        .catchAndReturn([])
        .withUnretained(self)
        .flatMap { wself, cards in wself.localDatabaseRepository.create(cards) }
        .flatMap { [weak self] cards -> Observable<Void> in
          self?.cards.accept(cards)
          return Observable.just(())
        }
    }
    
    return localDatabaseRepository.fetchAll()
      .withUnretained(self)
      .flatMap { wself, cards in wself.realtimeDatabaseRepository.create(cards) }
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable<Void>.just(())
      }
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
        return .just(())
      }
  }
}
