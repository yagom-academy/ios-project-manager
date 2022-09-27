//
//  PopoverViewCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/16.
//

import UIKit

final class PopoverViewCoordinator: Coordinator {
    var targetView: ListCollectionView
    var location: (x: Double, y: Double)
    var selectedTodo: Todo
    
    init(view: ListCollectionView,
         location: (x: Double, y: Double),
         selectedTodo: Todo) {
        self.targetView = view
        self.location = location
        self.selectedTodo = selectedTodo
    }
    
    func start() -> UIViewController {
        let popoverVM = PopoverViewModel(selectedTodo: selectedTodo)
        let popoverVC = PopoverViewController(viewModel: popoverVM)
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.permittedArrowDirections = .any
        popoverVC.popoverPresentationController?.delegate = targetView
        popoverVC.popoverPresentationController?.sourceView = targetView
        popoverVC.popoverPresentationController?.sourceRect = CGRect(x: location.x,
                                                                     y: location.y,
                                                                     width: 1,
                                                                     height: 1)
        return popoverVC
    }
}
