//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import Foundation

import RxRelay
import RxSwift

protocol CardListViewModelInput {
  func toCardListViewModelItem(card: Card) -> CardListViewModelItem
  func createNewCard(title: String?, description: String?, deadlineDate: Date)
  func updateSelectedCard(_ card: Card, title: String?, description: String?, deadlineDate: Date)
  func deleteSelectedCard(_ card: Card)
}
protocol CardListViewModelOutput {
  var todoCards: BehaviorRelay<[Card]> { get }
  var doingCards: BehaviorRelay<[Card]> { get }
  var doneCards: BehaviorRelay<[Card]> { get }
}

protocol CardListViewModel: CardListViewModelInput, CardListViewModelOutput {}

final class DefaultCardListViewModel: CardListViewModel {
  private let disposeBag = DisposeBag()
  
  private let cards = BehaviorRelay<[Card]>(value: Card.sample)
  
  // MARK: - Output
  
  let todoCards = BehaviorRelay<[Card]>(value: [])
  let doingCards = BehaviorRelay<[Card]>(value: [])
  let doneCards = BehaviorRelay<[Card]>(value: [])
  
  // MARK: - Init
  
  init() {
    cards
      .map { $0.filter { $0.cardType == .todo } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .bind(to: todoCards)
      .disposed(by: disposeBag)
    
    cards
      .map { $0.filter { $0.cardType == .doing } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .bind(to: doingCards)
      .disposed(by: disposeBag)
    
    cards
      .map { $0.filter { $0.cardType == .done } }
      .map { $0.sorted { $0.deadlineDate > $1.deadlineDate } }
      .bind(to: doneCards)
      .disposed(by: disposeBag)
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
  
  func createNewCard(title: String?, description: String?, deadlineDate: Date) {
    guard let title = title, let description = description else { return }
    
    let card = Card(title: title, description: description, deadlineDate: deadlineDate)
    cards.accept(cards.value + [card])
  }
  
  func updateSelectedCard(_ card: Card, title: String?, description: String?, deadlineDate: Date) {
    guard let title = title, let description = description else { return }
    
    let originCards = cards.value.filter { $0.id != card.id }
    var updatedCard = card
    updatedCard.title = title
    updatedCard.description = description
    updatedCard.deadlineDate = deadlineDate
    cards.accept(originCards + [updatedCard])
  }
  
  func deleteSelectedCard(_ card: Card) {
    cards.accept(cards.value.filter { $0.id != card.id })
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
