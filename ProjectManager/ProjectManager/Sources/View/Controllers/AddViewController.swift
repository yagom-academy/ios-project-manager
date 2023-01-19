//
//  AddViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import UIKit

final class AddViewController: ProjectViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
}

// MARK: Action Method
extension AddViewController {
    private func tapCancelButton(_ sender: UIAction) {
        dismiss(animated: true)
    }
    
    private func tapDoneButton(_ sender: UIAction) {
        guard let title = textField.text,
              let description = textView.text
        else {
            return
        }
        
        dismiss(animated: true)
    }
}

// MARK: UI Configuration
extension AddViewController {
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: UIAction(handler: tapDoneButton)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: UIAction(handler: tapCancelButton)
        )
    }
}
