//
//  CardViewModelProtocol.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

import UIKit

protocol CardViewModelProtocol {
    func convert(from card: CardModel) -> CardEntity
    func append(_ newCard: CardModel)
    func update(_ selectedCard: CardModel)
    func delete(_ cardType: CardType, at indextPath: Int)
    func move(_ card: CardModel?, to anotherCardSection: CardType)
    func connectWithActionSheetForMoving(coordinator: CoordinatorProtocol, model: CardModel, sourceView: UIView)

    var todoList: [CardModel]? { get set }
    var doingList: [CardModel]? { get set }
    var doneList: [CardModel]? { get set }

    var reloadTodoListTableViewClosure: (([CardModel]) -> Void)? { get set }
    var reloadDoingListTableViewClosure: (([CardModel]) -> Void)? { get set }
    var reloadDoneListTableViewClosure: (([CardModel]) -> Void)? { get set }
}
