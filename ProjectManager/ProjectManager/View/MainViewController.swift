//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol MainViewDelegate: AnyObject {
    func deleteWork(work: Work)
    func presentModal(_ viewController: UIViewController, animated: Bool)
}

final class MainViewController: UIViewController {
    private let viewModel = MainViewModel()
    
    private let todoListView = ListView(viewModel: ListViewModel(category: .todo))
    private let doingListView = ListView(viewModel: ListViewModel(category: .doing))
    private let doneListView = ListView(viewModel: ListViewModel(category: .done))
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemGray3
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureLayout()
        configureListView()
        configureBind()
        configureData()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(stackView)
        stackView.addArrangedSubview(todoListView)
        stackView.addArrangedSubview(doingListView)
        stackView.addArrangedSubview(doneListView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureListView() {
        [todoListView, doingListView, doneListView].forEach {
            $0.cellDelgate = self
            $0.workFormDelegate = self
            $0.mainViewDelegate = self
        }
    }
    
    private func configureBind() {
        viewModel.bindTodoList { [weak self] in
            self?.todoListView.didChangeWorkList(works: $0)
        }
        
        viewModel.bindDoingList { [weak self] in
            self?.doingListView.didChangeWorkList(works: $0)
        }
        
        viewModel.bindDoneList { [weak self] in
            self?.doneListView.didChangeWorkList(works: $0)
        }
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addTapped))
    }
    
    private func configureData() {
        viewModel.load()
    }
    
    @objc private func addTapped() {
        let workFormViewController = WorkFormViewController()
        let navigationViewController = UINavigationController(rootViewController: workFormViewController)
        
        workFormViewController.viewModel = WorkFormViewModel()
        workFormViewController.delegate = self
        navigationViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationViewController, animated: true)
    }
}

extension MainViewController: WorkFormDelegate, CellDelegate, MainViewDelegate {
    func deleteWork(work: Work) {
        viewModel.deleteWork(data: work)
    }
    
    func presentModal(_ viewController: UIViewController, animated: Bool) {
        present(viewController, animated: animated)
    }
    
    func showPopover(soruceView: UIView?, work: Work?) {
        guard let work else { return }
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        viewModel.categoryToOthers(category: work.category).forEach { (category: Category, title: String) in
            actionSheet.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
                self.viewModel.moveWork(data: work, category: category)
            }))
        }
        
        actionSheet.popoverPresentationController?.sourceView = soruceView
        present(actionSheet, animated: true)
    }
    
    func send(data: Work) {
        viewModel.updateWork(data: data)
    }
    
}
