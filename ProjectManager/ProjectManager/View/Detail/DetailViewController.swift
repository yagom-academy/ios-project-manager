//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/21.
//

import UIKit

final class DetailViewController: UIViewController {
    private var viewModel: WorkViewModel
    private var viewMode: WorkViewModel.ViewMode
    private let workInputView = WorkInputView()
    private var isEditable = false
    
    init(viewModel: WorkViewModel, viewMode: WorkViewModel.ViewMode) {
        self.viewModel = viewModel
        self.viewMode = viewMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
    }
    
    private func configureUIOption() {
        view = workInputView
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = "TODO"
        
        switch viewMode {
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(addWork))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(cancel))
        case .edit:
            guard let work = viewModel.fetchWork() else { return }

            workInputView.configure(title: work.title, body: work.body, deadline: work.deadline)
            workInputView.setEditing(isEditable)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(updateWork))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(toggleEditing))
        }
    }
    
    @objc private func addWork() {
        let contents = workInputView.checkContents()
        
        viewModel.addWork(title: contents.title,
                           body: contents.body,
                           deadline: contents.deadline)
        
        dismiss(animated: true)
    }
    
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    @objc private func updateWork() {
        let contents = workInputView.checkContents()
        
        viewModel.updateWork(
                              title: contents.title,
                              body: contents.body,
                              deadline: contents.deadline)
        
        dismiss(animated: true)
    }
    
    @objc private func toggleEditing() {
        isEditable.toggle()
        workInputView.setEditing(isEditable)
    }
}
