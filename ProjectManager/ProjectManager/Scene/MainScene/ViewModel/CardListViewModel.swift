//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import Foundation

import RxRelay
import RxSwift

protocol CardListViewModelInput {}
protocol CardListViewModelOutput {
  var cards: BehaviorRelay<[Card]> { get }
}

protocol CardListViewModelType {
  var input: CardListViewModelInput { get }
  var output: CardListViewModelOutput { get }
}

protocol CardListViewModel: CardListViewModelType, CardListViewModelInput, CardListViewModelOutput {}

final class DefaultCardListViewModel: CardListViewModel {
  var input: CardListViewModelInput { self }
  var output: CardListViewModelOutput { self }
  
  // Output
  let cards = BehaviorRelay<[Card]>(value: Card.sample)
}
