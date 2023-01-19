//
//  EditViewController.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/19.
//

import UIKit

final class EditViewController: ProjectViewController {
    private let viewModel: EditViewModel
    
    init(viewModel: EditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        viewModel.editingHandler = {
            self.toggleUserInteractionEnabled()
        }
        
        viewModel.changeEditMode(state: false)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        viewModel.changeEditMode(state: editing)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .done,
            primaryAction: UIAction(handler: tapDoneButton)
        )
    }
    
    func toggleUserInteractionEnabled() {
        [textView, textField, datePicker].forEach {
            $0.isUserInteractionEnabled.toggle()
        }
    }
}

// MARK: Action Method
extension EditViewController {
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
extension EditViewController {
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            systemItem: .cancel,
            primaryAction: UIAction(handler: tapCancelButton)
        )
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
}
