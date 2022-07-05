//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import Foundation
import RxCocoa

final class CardListViewModel: ViewModelType {
  struct Input {
    
  }
  struct Output {
    let cards: Driver<[Card]>
  }
  
  func transform(input: Input) -> Output {
    let cards = BehaviorRelay<[Card]>(value: Card.sample).asDriver()
    
    return Output(cards: cards)
  }
}
