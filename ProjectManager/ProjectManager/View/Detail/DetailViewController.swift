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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
    }
    
    func configureAddMode() {
        viewMode = .add
    }
    
    func configureEditMode() {
        viewMode = .edit
    }
    
    private func configureUIOption() {
        view = workInputView
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.title = viewModel?.works.first?.title
        
        switch viewMode {
        case .add:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(addWork))
        case .edit:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                style: .done,
                                                                target: self,
                                                                action: nil)
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
}
