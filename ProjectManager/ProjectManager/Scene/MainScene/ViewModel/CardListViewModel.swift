//
//  CardListViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/05.
//

import Foundation

import RxRelay
import RxSwift

final class CardListViewModel: ViewModelType {
  struct Input {}
  struct Output {
    let todoCards = BehaviorRelay<[Card]>(value: Card.todoSample)
    let doingCards = BehaviorRelay<[Card]>(value: Card.doingSample)
    let doneCards = BehaviorRelay<[Card]>(value: Card.doneSample)
  }
  
  func transform(input: Input) -> Output {
    let output = Output()
    return output
  }
}
