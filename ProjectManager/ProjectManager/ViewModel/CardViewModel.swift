//
//  CardViewModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/6/22.
//

import UIKit

final class CardViewModel {
    var reloadTodoListTableViewClosure: (([CardModel]) -> Void)?
    var reloadDoingListTableViewClosure: (([CardModel]) -> Void)?
    var reloadDoneListTableViewClosure: (([CardModel]) -> Void)?
    
    private var cardList: [CardModel]? {
        didSet {
            configureTableView()
        }
    }
    
    var todoList: [CardModel]? {
        didSet {
            if let todoList = todoList {
                reloadTodoListTableViewClosure?(todoList)
            }
        }
    }
    
    var doingList: [CardModel]? {
        didSet {
            if let doingList = doingList {
                reloadDoingListTableViewClosure?(doingList)
            }
        }
    }
    
    var doneList: [CardModel]? {
        didSet {
            if let doneList = doneList {
                reloadDoneListTableViewClosure?(doneList)
            }
        }
    }
    
    init() {
        self.cardList = CardModel.sample
        configureTableView()
    }
    
    private func configureTableView() {
        self.todoList = cardList?
            .filter { $0.cardType == .todo }
            .sorted { $0.deadlineDate < $1.deadlineDate }
        
        self.doingList = cardList?
            .filter { $0.cardType == .doing }
            .sorted { $0.deadlineDate < $1.deadlineDate }
        
        self.doneList = cardList?
            .filter { $0.cardType == .done }
            .sorted { $0.deadlineDate < $1.deadlineDate }
    }
    
    private func checkExpirationDate(_ model: CardModel) -> Bool {
        return ((model.cardType == .todo
                 || model.cardType == .doing)
                && Date() > model.deadlineDate)
    }
}

extension CardViewModel: CardViewModelProtocol {
    func convert(from card: CardModel) -> CardEntity {
        return CardEntity(
            id: card.id,
            title: card.title,
            description: card.description,
            deadlineDate: card.deadlineDate.formattedDate,
            isExpired: checkExpirationDate(card)
        )
    }
    
    func append(_ newCard: CardModel) {
        cardList?.append(newCard)
    }
    
    func update(_ selectedCard: CardModel) {
        cardList?.indices.forEach { index in
            if cardList?[index].id == selectedCard.id {
                cardList?[index] = selectedCard
            }
        }
    }

    func delete(_ cardType: CardType, at indextPath: Int) {
        switch cardType {
        case .todo:
            todoList?.remove(at: indextPath)
        case .doing:
            doingList?.remove(at: indextPath)
        default:
            doneList?.remove(at: indextPath)
        }
    }
    
    func move(_ card: CardModel?,
              to anotherCardSection: CardType) {
        if var cardModel = card {
            cardModel.cardType = anotherCardSection
            update(cardModel)
        }
    }
}

private extension Date {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
