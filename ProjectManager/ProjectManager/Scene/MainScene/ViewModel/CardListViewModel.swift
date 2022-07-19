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
  func deleteSelectedCard(_ card: Card)
  func moveDifferentSection(_ card: Card, to index: Int)
}

protocol CardListViewModelOutput {
  var todoCards: Driver<[Card]> { get }
  var doingCards: Driver<[Card]> { get }
  var doneCards: Driver<[Card]> { get }
}

protocol CardListViewModelable: CardListViewModelInput, CardListViewModelOutput {}

final class CardListViewModel: CardListViewModelable {
  // MARK: - Output
  
  let todoCards: Driver<[Card]>
  let doingCards: Driver<[Card]>
  let doneCards: Driver<[Card]>
  
  // MARK: - Init
  
  private let useCase: CardUseCase
  
  init(useCase: CardUseCase) {
    self.useCase = useCase
  
    todoCards = useCase.cards
      .map { $0.filter { $0.cardType == .todo } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .distinctUntilChanged { $0 == $1 }
      .asDriver(onErrorJustReturn: [])
    
    doingCards = useCase.cards
      .map { $0.filter { $0.cardType == .doing } }
      .map { $0.sorted { $0.deadlineDate < $1.deadlineDate } }
      .distinctUntilChanged { $0 == $1 }
      .asDriver(onErrorJustReturn: [])
    
    doneCards = useCase.cards
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
  
  func deleteSelectedCard(_ card: Card) {
    useCase.deleteSelectedCard(card)
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) {
    useCase.moveDifferentSection(card, to: index)
  }
}

// MARK: - Private

extension CardListViewModel {
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
