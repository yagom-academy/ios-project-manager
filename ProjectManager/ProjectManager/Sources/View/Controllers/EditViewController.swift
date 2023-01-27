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
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        viewModel.changeEditMode(editing)
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
    
    private func bindViewModel() {
        viewModel.titleHandler = { [weak self] title in
            self?.textField.text = title
        }
        
        viewModel.deadlineHandler = { [weak self] deadline in
            self?.datePicker.date = deadline
        }
        
        viewModel.descriptionHandler = { [weak self] description in
            self?.textView.text = description
        }
        
        viewModel.stateHandler = { [weak self] stateName in
            self?.navigationItem.title = stateName
        }
        
        viewModel.editingHandler = { [weak self] in
            self?.toggleUserInteractionEnabled()
        }
    }
}

// MARK: Action Method
extension EditViewController {
    private func tapCancelButton(_ sender: UIAction) {
        dismiss(animated: true)
    }
    
    private func tapDoneButton(_ sender: UIAction) {
        viewModel.updateProject(title: textField.text, deadline: datePicker.date, description: textView.text)
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
