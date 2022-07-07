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
  func setDeadlineDateToString(_ date: Date) -> String
  func isOverdue(card: Card) -> Bool
}
protocol CardListViewModelOutput {
  var cards: BehaviorRelay<[Card]> { get }
}

protocol CardListViewModel: CardListViewModelInput, CardListViewModelOutput {}

final class DefaultCardListViewModel: CardListViewModel {
  // Output
  let cards = BehaviorRelay<[Card]>(value: Card.sample)
  
  func setDeadlineDateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.locale = setPreferredLocale()
    return formatter.string(from: date)
  }
  
  private func setPreferredLocale() -> Locale {
    guard let preferredID = Locale.preferredLanguages.first else { return Locale.current }
    return Locale(identifier: preferredID)
  }
  
  func isOverdue(card: Card) -> Bool {
    return (card.cardType == .todo || card.cardType == .doing) && Date() > card.deadlineDate
  }
}
