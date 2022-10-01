//
//  CardListItemViewModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/28.
//

import UIKit

class CardListItemViewModel: CardListItemViewModelProtocol {
    private let model: CardModel
    
    private let coordinator: CoordinatorProtocol
    
    init(coordinator: CoordinatorProtocol,
         model: CardModel) {
        self.coordinator = coordinator
        self.model = model
    }
    
    var title: String {
        return model.title
    }
    
    var description: String {
        return model.title
    }
    
    var date: String {
        return model.deadlineDate.formattedDateForKoreanLocale
    }
    
    var isExpired: Bool {
        return checkExpirationDate(model)
    }
    
    func connectWithActionSheetForMoving(sourceView: UIView) {
        let (firstCard, secondCard) = distinguishCardType(of: model)
        
        coordinator.presentTableViewCellActionSheet(sourceView,
                                                    model: model,
                                                    firstCard: firstCard,
                                                    secondCard: secondCard)
    }
    
    private func checkExpirationDate(_ model: CardModel) -> Bool {
        return ((model.cardType == .todo
                 || model.cardType == .doing)
                && Date() > model.deadlineDate)
    }
    
    private func distinguishCardType(of model: CardModel) -> (CardType, CardType) {
        switch model.cardType {
        case .todo:
            return (.doing, .done)
        case .doing:
            return (.todo, .done)
        default:
            return (.todo, .doing)
        }
    }
}
