//
//  AddViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import UIKit

protocol AddActionDelegate: AnyObject {
    func addProject(title: String, deadline: Calendar, description: String)
}

final class AddViewController: ProjectViewController {
    weak var delegate: AddActionDelegate?
    
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
              let deadline = datePicker.calendar,
              let description = textView.text
        else {
            // 얼럿?
            return
        }
        delegate?.addProject(title: title, deadline: deadline, description: description)
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
