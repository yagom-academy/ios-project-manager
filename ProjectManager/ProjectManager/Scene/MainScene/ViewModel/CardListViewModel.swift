//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import RxSwift
import RxCocoa

final class CardListViewModel: ViewModelType {
  struct Input {
    
  }
  struct Output {
    let cards: Driver<[Card]>
  }
  
  func transform(input: Input) -> Output {
    let cards = BehaviorSubject<[Card]>(value: Card.sample).asDriver(onErrorJustReturn: [])
    
    return Output(cards: cards)
  }
}
