//
//  MenuPresentable.swift
//  ProjectManager
//  Created by inho on 2023/01/18.
//

import UIKit

protocol MenuPresentable: MainViewController {
    func didLongPressGesture(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel)
}

extension MenuPresentable {
    func didLongPressGesture(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel) {
        guard sender.state == .began else { return }
        
        showPopoverMenu(sender, viewModel)
    }
    
    func showPopoverMenu(_ sender: UIGestureRecognizer, _ viewModel: ListItemCellViewModel) {
        let actionTypes = ListType.allCases.filter { $0 != viewModel.listType }
        let menuAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        menuAlert.modalPresentationStyle = .popover
        menuAlert.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        menuAlert.popoverPresentationController?.sourceView = sender.view
        
        actionTypes.forEach {
            let action = makeAlertAction(of: $0, viewModel)
            
            menuAlert.addAction(action)
        }
        
        present(menuAlert, animated: true)
    }
    
    func makeAlertAction(of type: ListType, _ viewModel: ListItemCellViewModel) -> UIAlertAction {
        let title: String
        
        switch type {
        case .todo:
            title = Constant.moveToToDo
        case .doing:
            title = Constant.moveToDoing
        case .done:
            title = Constant.moveToDone
        }
        
        let action = UIAlertAction(title: title, style: .default) { _ in
            self.move(listItem: viewModel.currentItem, from: viewModel.listType, to: type)
            viewModel.moveType(to: type)
        }
        
        return action
    }
}

private enum Constant {
    static let moveToToDo = "Move to TODO"
    static let moveToDoing = "Move to DOING"
    static let moveToDone = "Move to DONE"
}
