//
//  CardHistoryItemViewModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/27.
//

import Foundation

class CardHistoryItemViewModel: CardHistoryItemViewModelProtocol {
    private let cardHistoryModel: CardHistoryModel

    init(cardHistoryModel: CardHistoryModel) {
        self.cardHistoryModel = cardHistoryModel
    }
    
    var title: String {
        switch cardHistoryModel.cardState {
        case .added:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)'."
        case .moved:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)' from \(cardHistoryModel.cardTypeDescription)."
        case .removed:
            return "\(cardHistoryModel.cardState.rawValue) '\(cardHistoryModel.title)' from \(cardHistoryModel.cardTypeDescription)."
        }
    }

    var date: String {
        let date = cardHistoryModel.date.formattedDateForUSALocale
        return date
    }
}
