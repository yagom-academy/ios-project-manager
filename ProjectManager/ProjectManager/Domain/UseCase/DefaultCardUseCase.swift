//
//  DefaultCardUseCase.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/18.
//

import Foundation

import RxRelay

protocol CardUseCase {
  var cards: BehaviorRelay<[Card]> { get }
  
  func createNewCard(_ card: Card)
  func updateSelectedCard(_ card: Card)
  func deleteSelectedCard(_ card: Card)
  func moveDifferentSection(_ card: Card, to index: Int)
}

final class DefaultCardUseCase: CardUseCase {
  private let repository: CardRepository
  
  let cards = BehaviorRelay<[Card]>(value: Card.sample)
  
  init(repository: CardRepository) {
    self.repository = repository
  }
  
  func createNewCard(_ card: Card) {
    cards.accept(cards.value + [card])
  }
  
  func updateSelectedCard(_ card: Card) {
    let originCards = cards.value.filter { $0.id != card.id }
    cards.accept(originCards + [card])
  }
  
  func deleteSelectedCard(_ card: Card) {
    cards.accept(cards.value.filter { $0.id != card.id })
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) {
    var newCard = card
    newCard.cardType = card.cardType.distinguishMenuType[index]
    self.updateSelectedCard(newCard)
  }
}
