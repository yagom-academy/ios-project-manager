//
//  ProjectManager - TodoListViewController.swift
//  Created by bonf.
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class TodoListViewController: UIViewController {
    
    // MARK: - properties
    
    private var todoView = ListView(status: .todo)
    private var doingView = ListView(status: .doing)
    private var doneView = ListView(status: .done)
    
    private let todoViewModel = TodoViewModel()
    private let doingViewModel = DoingViewModel()
    private let doneViewModel = DoneViewModel()
    
    private var addButtonAction = PublishSubject<Project>()
    
    private var todoViewOutput: TodoViewOutput?
    private var doingViewOutput: DoingViewOutput?
    private var doneViewOutput: DoneViewOutput?
    
    private var disposeBag = DisposeBag()
    
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 8
        
        return stackView
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupListStackView()
        
        setupListsCell()
        setupListCount()
        setupListsCellTouchEvent()
    }
}

// MARK: - functions

extension TodoListViewController {
    private func setupListStackView() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(listStackView)
        listStackView.addArrangedSubview(todoView)
        listStackView.addArrangedSubview(doingView)
        listStackView.addArrangedSubview(doneView)
        
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupNavigationItem() {
        navigationItem.title = Design.navigationItemTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(showAddView))
    }
    
    private func setupListsCell() {
        let todoInput = TodoViewInput(addButtonAction: addButtonAction)
        let doingInput = DoingViewInput()
        let doneInput = DoneViewInput()
        todoViewOutput = todoViewModel.transform(todoInput)
        doingViewOutput = doingViewModel.transform(doingInput)
        doneViewOutput = doneViewModel.transform(doneInput)
        guard let todoViewOutput = todoViewOutput,
              let doingViewOutput = doingViewOutput,
              let doneViewOutput = doneViewOutput else { return }
        
        todoViewOutput.todoList
            .bind(to: todoView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)

        doingViewOutput.doingList
            .bind(to: doingView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)

        doneViewOutput.doneList
            .bind(to: doneView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)
    }
    
    private func setupListCount() {
        guard let todoViewOutput = todoViewOutput,
              let doingViewOutput = doingViewOutput,
              let doneViewOutput = doneViewOutput else { return }

        todoViewOutput.todoList
            .map { $0.count }
            .map { "\($0)"}
            .bind(to: todoView.listCountLabel.rx.text)
            .disposed(by: disposeBag)

        doingViewOutput.doingList
            .map { $0.count }
            .map { "\($0)"}
            .bind(to: doingView.listCountLabel.rx.text)
            .disposed(by: disposeBag)

        doneViewOutput.doneList
            .map { $0.count }
            .map { "\($0)"}
            .bind(to: doneView.listCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupListsCellTouchEvent() {
        todoView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
//                projectViewController.setupData(project: project)
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        doingView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
        doneView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.todoView.tableView.deselectRow(at: indexPath, animated: true)
                print(indexPath.row)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet
                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self?.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - objc functions

extension TodoListViewController {
    @objc private func showAddView() {
        let projectViewController = ProjectViewController()
        projectViewController.doneButton.rx.tap
            .subscribe(onNext: { _ in
                guard let todo = projectViewController.getProjectData() else { return }
                self.addButtonAction.onNext(todo)
                projectViewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        projectViewController.cancelButton.rx.tap
            .subscribe(onNext: { _ in
                projectViewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
//        projectViewController.viewModel = todoViewModel
        projectViewController.modalPresentationStyle = .formSheet
        let projectAddViewController = UINavigationController(rootViewController: projectViewController)
        present(projectAddViewController, animated: true)
    }
}

private enum Design {
    static let navigationItemTitle = "Project Manager"
}
