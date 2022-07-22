//
//  CardDetailViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/18.
//

import Foundation

import RxSwift

protocol CardDetailViewModelInput {
  func updateSelectedCard(_ card: Card) -> Observable<Void>
}

protocol CardDetailViewModelOutput {}

protocol CardDetailViewModelable: CardDetailViewModelInput, CardDetailViewModelOutput {}

final class CardDetailViewModel: CardDetailViewModelable {
  // MARK: - Init
  
  private weak var useCase: CardUseCase?
  
  init(useCase: CardUseCase) {
    self.useCase = useCase
  }
  
  // MARK: - Input
  
  func updateSelectedCard(_ card: Card) -> Observable<Void> {
    return useCase?.updateSelectedCard(card) ?? .empty()
  }
}
