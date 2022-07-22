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
  func fetchCards() -> Observable<Void>
  func toCardListViewModelItem(card: Card) -> CardListViewModelItem
  func toCardHistoryViewModelItem(history: History) -> CardHistoryViewModelItem
  func deleteSelectedCard(_ card: Card) -> Observable<Void>
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void>
}

protocol CardListViewModelOutput {
  var todoCards: Driver<[Card]> { get }
  var doingCards: Driver<[Card]> { get }
  var doneCards: Driver<[Card]> { get }
  var histories: Driver<[History]> { get }
}

protocol CardListViewModelable: CardListViewModelInput, CardListViewModelOutput {}

final class CardListViewModel: CardListViewModelable {
  // MARK: - Output
  
  let todoCards: Driver<[Card]>
  let doingCards: Driver<[Card]>
  let doneCards: Driver<[Card]>
  let histories: Driver<[History]>
  
  // MARK: - Init
  
  private weak var useCase: CardUseCase?
  
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
    
    histories = useCase.histories
      .map { $0.sorted { $0.actionTime > $1.actionTime } }
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
  
  func toCardHistoryViewModelItem(history: History) -> CardHistoryViewModelItem {
    return CardHistoryViewModelItem(
      card: history.card,
      actionType: history.actionType,
      actionTimeString: setDeadlineDateToString(history.actionTime),
      informationString: setInformationString(history)
    )
  }
  
  func fetchCards() -> Observable<Void> {
    useCase?.fetchCards() ?? .empty()
  }
  
  func deleteSelectedCard(_ card: Card) -> Observable<Void> {
    return useCase?.deleteSelectedCard(card) ?? .empty()
  }
  
  func moveDifferentSection(_ card: Card, to index: Int) -> Observable<Void> {
    return useCase?.moveDifferentSection(card, to: index) ?? .empty()
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
  
  private func setInformationString(_ history: History) -> String {
    if case .move(let destinationCardType) = history.actionType {
       return "\(history.card.cardType.description) ➡️ \(destinationCardType.description)"
    }
    return "\(history.card.cardType.description)"
  }
}
