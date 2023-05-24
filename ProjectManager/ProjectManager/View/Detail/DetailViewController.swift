//
//  DetailViewController.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/21.
//

import UIKit

final class DetailViewController: UIViewController {
    private enum ViewMode {
        case add
        case edit
    }
    
    var viewModel: WorkViewModel?
    private var viewMode: ViewMode?
    private let workInputView = WorkInputView()
    private var isEditable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
    }
    
    func configureAddMode() {
        viewMode = .add
    }
    
    func configureEditMode() {
        viewMode = .edit
        
        guard let work = viewModel?.fetchWork() else { return }

        workInputView.configure(title: work.title, body: work.body, deadline: work.deadline)
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
            workInputView.setEditing(isEditable)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(updateWork))
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit",
                                                               style: .done,
                                                               target: self,
                                                               action: #selector(toggleEditing))
        case .none:
            AlertManager().showErrorAlert(target: self, title: "오류", message: "잘못된 접근입니다.") { [weak self] in
                self?.dismiss(animated: true)
            }
        }
    }
    
    @objc private func addWork() {
        let contents = workInputView.checkContents()
        
        viewModel?.addWork(title: contents.title,
                           body: contents.body,
                           deadline: contents.deadline)
        
        self.dismiss(animated: true)
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true)
    }
    
    @objc private func updateWork() {
        let contents = workInputView.checkContents()
        
        viewModel?.updateWork(
                              title: contents.title,
                              body: contents.body,
                              deadline: contents.deadline)
        
        self.dismiss(animated: true)
    }
    
    @objc private func toggleEditing() {
        isEditable.toggle()
        workInputView.setEditing(isEditable)
    }
}
