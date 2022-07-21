//
//  CardAdditionViewModel.swift
//  ProjectManager
//
//  Created by Lingo on 2022/07/18.
//

import Foundation

import RxSwift

protocol CardAdditionViewModelInput {
  func createNewCard(_ card: Card)
}

protocol CardAdditionViewModelOutput {}

protocol CardAdditionViewModelable: CardAdditionViewModelInput, CardAdditionViewModelOutput {}

final class CardAdditionViewModel: CardAdditionViewModelable {
  // MARK: - Init
  
  private weak var useCase: CardUseCase?
  
  init(useCase: CardUseCase) {
    self.useCase = useCase
  }
  
  // MARK: - Input
  
  func createNewCard(_ card: Card) {
    useCase?.createNewCard(card)
  }
}
