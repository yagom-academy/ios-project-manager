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

final class DefaultCardUseCase: CardUseCase {
  private let repository: CardRepository
  private let disposeBag = DisposeBag()
  
  let cards = BehaviorRelay<[Card]>(value: [])
  let histories = BehaviorRelay<[History]>(value: [])
  
  init(repository: CardRepository) {
    self.repository = repository
  }
  
  func fetchCards() -> Observable<Void> {
    return repository.fetchCards()
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable<Void>.just(())
      }
  }
  
  func createNewCard(_ card: Card) -> Observable<Void> {
    return repository.createCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .create, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable.just(())
      }
  }
  
  func updateSelectedCard(_ card: Card) -> Observable<Void> {
    return repository.updateCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .update, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable.just(())
      }
  }
  
  func deleteSelectedCard(_ card: Card) -> Observable<Void> {
    return repository.deleteCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .delete, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable.just(())
      }
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void> {
    var newCard = card
    newCard.cardType = card.cardType.distinguishMenuType[index]
    
    return repository.updateCard(newCard)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .move(newCard.cardType), actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .flatMap { [weak self] cards -> Observable<Void> in
        self?.cards.accept(cards)
        return Observable.just(())
      }
  }
}
