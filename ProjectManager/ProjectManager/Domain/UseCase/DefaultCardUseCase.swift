//
//  DefaultCardUseCase.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/18.
//

import Foundation

import RxRelay
import RxSwift

protocol CardUseCase {
  var cards: BehaviorRelay<[Card]> { get }
  var histories: BehaviorRelay<[History]> { get }
  
  func fetchCards()
  func createNewCard(_ card: Card)
  func updateSelectedCard(_ card: Card)
  func deleteSelectedCard(_ card: Card)
  func moveDifferentSection(_ card: Card, to index: Int)
}

final class DefaultCardUseCase: CardUseCase {
  private let repository: CardRepository
  private let disposeBag = DisposeBag()
  
  let cards = BehaviorRelay<[Card]>(value: Card.sample)
  let histories = BehaviorRelay<[History]>(value: [])
  
  init(repository: CardRepository) {
    self.repository = repository
  }
  
  func fetchCards() {
    repository.fetchCards()
      .bind(to: cards)
      .disposed(by: disposeBag)
  }
  
  func createNewCard(_ card: Card) {
    repository.createCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .create, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .bind(to: cards)
      .disposed(by: disposeBag)
  }
  
  func updateSelectedCard(_ card: Card) {
    repository.updateCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .update, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .bind(to: cards)
      .disposed(by: disposeBag)
  }
  
  func deleteSelectedCard(_ card: Card) {
    repository.deleteCard(card)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .delete, actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .bind(to: cards)
      .disposed(by: disposeBag)
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) {
    var newCard = card
    newCard.cardType = card.cardType.distinguishMenuType[index]
    
    repository.updateCard(newCard)
      .withUnretained(self)
      .flatMap { wself, _ -> Observable<[Card]> in
        let history = History(card: card, actionType: .move(newCard.cardType), actionTime: Date())
        wself.histories.accept(wself.histories.value + [history])
        return wself.repository.fetchCards()
      }
      .bind(to: cards)
      .disposed(by: disposeBag)
  }
}
