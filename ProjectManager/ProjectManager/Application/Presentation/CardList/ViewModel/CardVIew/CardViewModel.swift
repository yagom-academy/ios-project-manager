//
//  CardViewModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/6/22.
//

import UIKit

class CardViewModel {
    private enum Const {
        static let networkNotConnectingMessage = "네트워크 연결이 끊어졌습니다."
    }

    var reloadTodoListTableViewClosure: (([CardModel]) -> Void)?
    var reloadDoingListTableViewClosure: (([CardModel]) -> Void)?
    var reloadDoneListTableViewClosure: (([CardModel]) -> Void)?

    var presentNetworkingAlert: (() -> Void)?

    private let repositoryService = RepositoryService.shared

    private let networkManager = NetworkManager.shared

    private var cardList: [CardModel]? = [] {
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

    var alertMessage: String? {
        didSet {
            presentNetworkingAlert?()
        }
    }
    
    init() {
        if !networkManager.isConnected {
            alertMessage = Const.networkNotConnectingMessage
        }

        fetchData()
    }

    private func fetchData() {
        self.cardList = repositoryService.fetchCardModel()
    }
    
    private func configureTableView() {
        self.todoList = sortList(by: .todo)
        self.doingList = sortList(by: .doing)
        self.doneList = sortList(by: .done)
    }

    private func sortList(by cardType: CardType) -> [CardModel]? {
        return cardList?
            .filter { $0.cardType == cardType }
            .sorted { $0.deadlineDate < $1.deadlineDate }
    }
}

extension CardViewModel: CardViewModelProtocol {    
    func append(_ newCard: CardModel) {
        do {
            try repositoryService.save(newCard)
        } catch {
            alertMessage = error.localizedDescription
        }
        fetchData()
    }
    
    func update(_ selectedCard: CardModel) {
        do {
            try repositoryService.update(selectedCard)
        } catch {
            alertMessage = error.localizedDescription
        }
        fetchData()
    }

    func delete(_ cardType: CardType,
                at indextPath: Int) {
        guard let model = sortList(by: cardType) else { return }

        do {
            try repositoryService.delete(model[indextPath])
        } catch {
            alertMessage = error.localizedDescription
        }
        fetchData()
    }
    
    func move(_ card: CardModel?,
              to anotherCardSection: CardType) {
        guard var cardModel = card else { return }
        cardModel.cardType = anotherCardSection

        update(cardModel)

        do {
            try repositoryService.saveHistory(cardModel)
        } catch {
            alertMessage = error.localizedDescription
        }
    }
}
