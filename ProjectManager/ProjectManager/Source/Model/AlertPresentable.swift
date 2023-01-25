//
//  AlertPresentable.swift
//  ProjectManager
//
//  Created by Dragon on 2023/01/25.
//

import UIKit

protocol AlertPresentable: UIViewController {
    func createLeftTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                        _ secondHandler: @escaping () -> Void)
    func createCenterTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                          _ secondHandler: @escaping () -> Void)
    func createRightTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                         _ secondHandler: @escaping () -> Void)
}

extension AlertPresentable {
    func createLeftTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                        _ secondHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let moveToDoing = UIAlertAction(
            title: NameSpace.moveToDoing,
            style: .default) { _ in
                firstHandler()
            }
        let moveToDone = UIAlertAction(
            title: NameSpace.moveToDone,
            style: .default) { _ in
                secondHandler()
            }
        
        actionSheet.addAction(moveToDoing)
        actionSheet.addAction(moveToDone)
        
        checkPopOverPresentation(device: .pad, actionSheet: actionSheet, view: view)
        
        present(actionSheet, animated: true)
    }
    
    func createCenterTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                          _ secondHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let moveToTodo = UIAlertAction(
            title: NameSpace.moveToTodo,
            style: .default) { _ in
                firstHandler()
            }
        let moveToDone = UIAlertAction(
            title: NameSpace.moveToDone,
            style: .default) { _ in
                secondHandler()
            }
        
        actionSheet.addAction(moveToTodo)
        actionSheet.addAction(moveToDone)
        
        checkPopOverPresentation(device: .pad, actionSheet: actionSheet, view: view)
        
        present(actionSheet, animated: true)
    }
    
    func createRightTableViewActionSheet(_ firstHandler: @escaping () -> Void,
                                         _ secondHandler: @escaping () -> Void) {
        let actionSheet = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        let moveToTodo = UIAlertAction(
            title: NameSpace.moveToTodo,
            style: .default) { _ in
                firstHandler()
            }
        let moveToDoing = UIAlertAction(
            title: NameSpace.moveToDoing,
            style: .default) { _ in
                secondHandler()
            }
        
        actionSheet.addAction(moveToTodo)
        actionSheet.addAction(moveToDoing)
        
        checkPopOverPresentation(device: .pad, actionSheet: actionSheet, view: view)
        
        present(actionSheet, animated: true)
    }
    
    private func checkPopOverPresentation(device: UIUserInterfaceIdiom,
                                          actionSheet: UIAlertController,
                                          view: UIView) {
        if device == .pad {
            if let presenter = actionSheet.popoverPresentationController {
                presenter.permittedArrowDirections = []
                presenter.sourceView = view
                presenter.sourceRect = CGRect(
                    x: view.bounds.midX,
                    y: view.bounds.maxY,
                    width: 0,
                    height: 0
                )
            }
        }
    }
}

// MARK: - NameSpace

private enum NameSpace {
    static let moveToTodo = "Move to TODO"
    static let moveToDoing = "Move to DOING"
    static let moveToDone = "Move to DONE"
}
