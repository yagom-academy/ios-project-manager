//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import Foundation

import RxCocoa
import RxSwift

protocol CardListViewModelInput {
  func toCardListViewModelItem(card: Card) -> CardListViewModelItem
  func createNewCard(_ card: Card)
  func updateSelectedCard(_ card: Card)
  func deleteSelectedCard(_ card: Card)
  func moveDifferentSection(_ card: Card, to index: Int)
}

protocol CardListViewModelOutput {
  var todoCards: Driver<[Card]> { get }
  var doingCards: Driver<[Card]> { get }
  var doneCards: Driver<[Card]> { get }
}

protocol CardListViewModelable: CardListViewModelInput, CardListViewModelOutput, AnyObject {}

final class DefaultCardListViewModel: CardListViewModelable {
  private let cards = BehaviorRelay<[Card]>(value: Card.sample)
  
  // MARK: - Output
  
  let todoCards: Driver<[Card]>
  let doingCards: Driver<[Card]>
  let doneCards: Driver<[Card]>
  
  // MARK: - Init
  
  init() {
    todoCards = cards
      .map { $0.filter { $0.cardType == .todo } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .distinctUntilChanged { $0 == $1 }
      .asDriver(onErrorJustReturn: [])
    
    doingCards = cards
      .map { $0.filter { $0.cardType == .doing } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .distinctUntilChanged { $0 == $1 }
      .asDriver(onErrorJustReturn: [])
    
    doneCards = cards
      .map { $0.filter { $0.cardType == .done } }
      .map { $0.sorted { $0.deadlineDate > $1.deadlineDate } }
      .distinctUntilChanged { $0 == $1 }
      .asDriver(onErrorJustReturn: [])
  }
  
  // MARK: - Input
  
  func toCardListViewModelItem(card: Card) -> CardListViewModelItem {
    return CardListViewModelItem(
      id: card.id,
      title: card.title,
      description: card.description,
      deadlineDateString: setDeadlineDateToString(card.deadlineDate),
      isOverdue: isOverdue(card: card)
    )
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

// MARK: - Private

extension DefaultCardListViewModel {
  private func setDeadlineDateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.locale = setPreferredLocale()
    return formatter.string(from: date)
  }
  
  private func setPreferredLocale() -> Locale {
    guard let preferredID = Locale.preferredLanguages.first else { return Locale.current }
    return Locale(identifier: preferredID)
  }
  
  private func isOverdue(card: Card) -> Bool {
    return (card.cardType == .todo || card.cardType == .doing) && Date() > card.deadlineDate
  }
}
