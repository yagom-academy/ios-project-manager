//
//  PopoverViewCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/16.
//

import UIKit

final class PopoverViewCoordinator: Coordinator {
    var viewModel: TodoListViewModel
    var targetView: ListCollectionView
    var location: (x: Double, y: Double)
    var selectedTodo: Todo
    
    init(viewModel: TodoListViewModel,
         view: ListCollectionView,
         location: (x: Double, y: Double),
         selectedTodo: Todo) {
        self.viewModel = viewModel
        self.targetView = view
        self.location = location
        self.selectedTodo = selectedTodo
    }
    
    func start() -> UIViewController {
        let popoverVC = PopoverViewController(
            viewModel: viewModel,
            selectedTodo: selectedTodo
        )
        popoverVC.preferredContentSize = CGSize(
            width: 250,
            height: 120
        )
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.sourceView = targetView
        popoverVC.popoverPresentationController?.sourceRect = CGRect(
            x: location.x,
            y: location.y,
            width: 1,
            height: 1
        )
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.delegate = targetView
        return popoverVC
    }
}
