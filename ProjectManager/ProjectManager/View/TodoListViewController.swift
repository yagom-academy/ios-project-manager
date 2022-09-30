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
    
    private var doneAction = PublishSubject<Project>()
    private var editAction = PublishSubject<Project>()
    private var changeStatusAction = PublishSubject<(UUID, Status)>()
    private var deleteAction = PublishSubject<UUID>()
    
    private var todoViewOutput: TodoViewOutput?
    
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
        setupDeleteAction()
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
                                                            action: #selector(addButtonDidTapped))
    }
    
    private func setupListsCell() {
        let todoInput = TodoViewInput(addAction: doneAction,
                                      updateAction: editAction,
                                      changeStatusAction: changeStatusAction,
                                      deleteAction: deleteAction)
        
        todoViewOutput = todoViewModel.transform(todoInput)
        guard let todoViewOutput = todoViewOutput else { return }
        
        todoViewOutput.projectList
            .map { $0.filter { $0.status == .todo } }
            .bind(to: todoView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)
        
        todoViewOutput.projectList
            .map { $0.filter { $0.status == .doing } }
            .bind(to: doingView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)
        
        todoViewOutput.projectList
            .map { $0.filter { $0.status == .done } }
            .bind(to: doneView.tableView.rx.items(
                cellIdentifier: TodoTableViewCell.identifier,
                cellType: TodoTableViewCell.self)) { _, item, cell in
                    cell.setupDataSource(project: item)
                }
                .disposed(by: disposeBag)
    }
    
    private func setupListCount() {
        guard let todoViewOutput = todoViewOutput else { return }

        todoViewOutput.projectList
            .bind(onNext: { [weak self] in
                let doingProjects = $0.filter { $0.status == .todo }
                self?.todoView.listCountLabel.rx.text.onNext("\(doingProjects.count)")
            })
            .disposed(by: disposeBag)

        todoViewOutput.projectList
            .bind(onNext: { [weak self] in
                let doingProjects = $0.filter { $0.status == .doing }
                self?.doingView.listCountLabel.rx.text.onNext("\(doingProjects.count)")
            })
            .disposed(by: disposeBag)

        todoViewOutput.projectList
            .bind(onNext: { [weak self] in
                let doingProjects = $0.filter { $0.status == .done }
                self?.doneView.listCountLabel.rx.text.onNext("\(doingProjects.count)")
            })
            .disposed(by: disposeBag)
    }
    
    private func setupListsCellTouchEvent() {
        tableViewItemSelected(view: todoView)
        tableViewItemSelected(view: doingView)
        tableViewItemSelected(view: doneView)
        
        setupLongPressAction()
    }
    
    private func tableViewItemSelected(view: ListView) {
        view.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }

                view.tableView.deselectRow(at: indexPath, animated: true)
                let projectViewController = ProjectViewController()
                projectViewController.modalPresentationStyle = .formSheet

                self.todoViewModel.projectList.subscribe(onNext: { projects in
                    projectViewController.setupData(project: projects[indexPath.row])
                })
                .disposed(by: self.disposeBag)

                self.editButtonAction(viewController: projectViewController)
                self.cancelButtonAction(viewController: projectViewController)

                let projectAddViewController = UINavigationController(rootViewController: projectViewController)
                self.present(projectAddViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func doneButtonAction(viewController: ProjectViewController) {
        viewController.doneButton.rx.tap
            .subscribe(onNext: { _ in
                guard let todo = viewController.getProjectData() else { return }
                self.doneAction.onNext(todo)
                viewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func editButtonAction(viewController: ProjectViewController) {
        viewController.editButton.rx.tap
            .subscribe(onNext: { _ in
                guard let todo = viewController.getProjectData() else { return }
                self.editAction.onNext(todo)
                viewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func cancelButtonAction(viewController: ProjectViewController) {
        viewController.cancelButton.rx.tap
            .subscribe(onNext: { _ in
                viewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupLongPressAction() {
        let todoViewLongPress = UILongPressGestureRecognizer(target: self, action: #selector(todoViewLongPress(_:)))
        self.todoView.tableView.addGestureRecognizer(todoViewLongPress)
        todoViewLongPress.minimumPressDuration = 1
        
        let doingViewLongPress = UILongPressGestureRecognizer(target: self, action: #selector(doingViewLongPress(_:)))
        self.doingView.tableView.addGestureRecognizer(doingViewLongPress)
        doingViewLongPress.minimumPressDuration = 1
        
        let doneViewLongPress = UILongPressGestureRecognizer(target: self, action: #selector(doneViewLongPress(_:)))
        self.doneView.tableView.addGestureRecognizer(doneViewLongPress)
        doneViewLongPress.minimumPressDuration = 1
    }
    
    private func longPressAction(status: Status, cell: TodoTableViewCell, sourceView: UIView?) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        
        Status.allCases.filter { $0 != status }
            .forEach { status in
                let moveToAction = UIAlertAction(title: "moveTo\(status.upperCasedString)",
                                                 style: .default) { [weak self] _ in
                    guard let id = cell.cellID else { return }
                    self?.changeStatusAction.onNext((id, status))
                }
                alertController.addAction(moveToAction)
            }
        
        guard let popController = alertController.popoverPresentationController else { return }
        popController.permittedArrowDirections = []
        popController.sourceView = sourceView
        self.navigationController?.present(alertController, animated: true)
    }
    
    private func setupDeleteAction() {
        todoView.tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.todoView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell,
                      let id = cell.cellID else { return }
                self?.deleteAction.onNext(id)
            })
            .disposed(by: disposeBag)
        
        doingView.tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.doingView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell,
                      let id = cell.cellID else { return }
                self?.deleteAction.onNext(id)
            })
            .disposed(by: disposeBag)
        
        doneView.tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let cell = self?.doneView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell,
                      let id = cell.cellID else { return }
                self?.deleteAction.onNext(id)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - objc functions

extension TodoListViewController {
    @objc private func addButtonDidTapped() {
        let projectViewController = ProjectViewController()
        doneButtonAction(viewController: projectViewController)
        cancelButtonAction(viewController: projectViewController)
        projectViewController.modalPresentationStyle = .formSheet
        let projectAddViewController = UINavigationController(rootViewController: projectViewController)
        present(projectAddViewController, animated: true)
    }
    
    @objc func todoViewLongPress(_ guesture: UILongPressGestureRecognizer) {
        let point = guesture.location(in: todoView.tableView)
        guard let indexPath = self.todoView.tableView.indexPathForRow(at: point),
        let cell = self.todoView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell else { return }
        if guesture.state == UIGestureRecognizer.State.began {
            longPressAction(status: .todo, cell: cell, sourceView: guesture.view)
        }
    }
    
    @objc func doingViewLongPress(_ guesture: UILongPressGestureRecognizer) {
        let point = guesture.location(in: doingView.tableView)
        guard let indexPath = self.doingView.tableView.indexPathForRow(at: point),
        let cell = self.doingView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell else { return }
        if guesture.state == UIGestureRecognizer.State.began {
            longPressAction(status: .doing, cell: cell, sourceView: guesture.view)
        }
    }
    
    @objc func doneViewLongPress(_ guesture: UILongPressGestureRecognizer) {
        let point = guesture.location(in: doneView.tableView)
        guard let indexPath = self.doneView.tableView.indexPathForRow(at: point),
        let cell = self.doneView.tableView.cellForRow(at: indexPath) as? TodoTableViewCell else { return }
        if guesture.state == UIGestureRecognizer.State.began {
            longPressAction(status: .done, cell: cell, sourceView: guesture.view)
        }
    }
}

private enum Design {
    static let navigationItemTitle = "Project Manager"
}
