//
//  MenuPresentable.swift
//  ProjectManager
//  Created by inho on 2023/01/18.
//

import UIKit

protocol MenuPresentable: UIViewController {
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
            let action = makeAlertAction(of: $0)
            
            menuAlert.addAction(action)
        }
        
        present(menuAlert, animated: true)
    }
    
    func makeAlertAction(of type: ListType) -> UIAlertAction {
        let title: String
        
        switch type {
        case .todo:
            title = "Move To TODO"
        case .doing:
            title = "Move To DOING"
        case .done:
            title = "Move To DONE"
        }
        
        let action = UIAlertAction(title: title, style: .default, handler: nil)
        
        return action
    }
}
