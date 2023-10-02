//
//  EditProjectViewController.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/26.
//

import UIKit
import Combine

final class EditProjectViewController: ProjectDetailViewController {
    
    // MARK: - Private ProPerty
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Life Cycle
    override init(viewModel: ProjectDetailViewModel) {
        super.init(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View event
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupBindings()
    }
    
    @objc private func tapEditButton() {
        viewModel.tapEditButton()
    }
    
    // MARK: - Data Binding
    private func setupBindings() {
        textField.text = viewModel.title
        textView.text = viewModel.body
        datePicker.date = viewModel.deadlineDate
        
        viewModel.isEditingPublisher.sink { [weak self] isEditing in
            guard let self else {
                return
            }
            
            self.configureViewObjectInput(isEditing)
        }.store(in: &cancellables)
    }
}

// MARK: - Configure UI
extension EditProjectViewController {
    private func configureUI() {
        configureNavigation()
    }
    
    private func configureNavigation() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapEditButton))
        
        navigationItem.leftBarButtonItem = editButton
    }
    
    private func configureViewObjectInput(_ isInput: Bool) {
        textField.isEnabled = isInput
        textView.isEditable = isInput
        datePicker.isEnabled = isInput
    }
}
