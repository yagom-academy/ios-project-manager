//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol TaskDelegate: AnyObject {
    func saveTask(_ task: Task)
    func editTask(_ task: Task)
}

final class MainViewController: UIViewController {
    
    let viewModel = MainViewModel()
    
    private let todoViewController = ListViewController(taskState: .todo)
    private let doingViewController = ListViewController(taskState: .doing)
    private let doneViewController = ListViewController(taskState: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
        configureChildViewControllerUI()
        configureObserver()
        bindCollectionView()
        configureViewModel()
    }
    
    func presentTodoViewController(_ state: TodoState, _ task: Task?) {
        let todoViewController = TodoViewController(taskDelegate: self, state: state, task: task)
        let navigationController = UINavigationController(rootViewController: todoViewController)
        
        navigationController.modalPresentationStyle = .formSheet
        
        self.present(navigationController, animated: true)
    }
    
    @objc private func bindCollectionView() {
        let todoTasks = viewModel.filterTasks(by: .todo)
        let doingTasks = viewModel.filterTasks(by: .doing)
        let doneTasks = viewModel.filterTasks(by: .done)
        
        todoViewController.appendTasks(todoTasks)
        doingViewController.appendTasks(doingTasks)
        doneViewController.appendTasks(doneTasks)
    }
    
    @objc private func bindErrorHandler(_ noti: Notification) {
        guard let error = noti.userInfo?["error"] as? Error else {
            return
        }
        
        showErrorAlert(error)
    }
    
    private func bindNetworkStateHandler(isConnect: Bool) {
        navigationItem.title = isConnect == true ? "Project Manager" : "🔴 Project Manager"
        navigationItem.rightBarButtonItem?.isEnabled = isConnect == true ? true : false
        
        todoViewController.viewModel.isNetworkConnecting = isConnect
        doingViewController.viewModel.isNetworkConnecting = isConnect
        doneViewController.viewModel.isNetworkConnecting = isConnect
        
        let title = "네트워크 연결 확인"
        let message = isConnect == true ? "네트워크가 연결되었습니다." : "네트워크 상태를 확인해주세요"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
    @objc private func didTapAddButton() {
        presentTodoViewController(.create, nil)
    }
    
    @objc private func didTapHistoryButton() {
        let historyVC = HistoryViewController(histoies: viewModel.historyTasks)
        
        historyVC.modalPresentationStyle = .popover
        historyVC.popoverPresentationController?.barButtonItem = self.navigationItem.leftBarButtonItem
        
        present(historyVC, animated: true)
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(bindCollectionView),
                                               name: .changedTasks,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(bindErrorHandler(_:)),
                                               name: .errorTask,
                                               object: nil)
    }
    
    private func configureViewModel() {
        viewModel.networkStateHandler = bindNetworkStateHandler(isConnect:)
        viewModel.configure()
    }
}

extension MainViewController: TaskDelegate {
    func editTask(_ task: Task) {
        viewModel.replaceTask(task)
    }

    func saveTask(_ task: Task) {
        viewModel.appendTask(task)
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(didTapHistoryButton))
    }
    
    private func configureViewUI() {
        self.view.backgroundColor = .systemGray5
    }
    
    private func configureChildViewControllerUI() {
        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)
        
        let stackView = UIStackView()
        
        children.forEach { childViewController in
            stackView.addArrangedSubview(childViewController.view)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
