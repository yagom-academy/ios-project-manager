//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxGesture

final class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    fileprivate enum Constants {
        static let title: String = "Project Manager"
        static let plus: String = "plus"
        static let popoverWidthRatio: Double = 0.25
        static let popoverHeightRatio: Double = 0.15
    }
    
    private let mainView = MainView()
    private let realmManager = RealmManager()
    private let viewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItems()
        bind()
        viewModel.viewDidLoad()
    }
    
    private func configureNavigationItems() {
        title = Constants.title
        let plusButton = UIBarButtonItem(
            image: UIImage(systemName: Constants.plus),
            style: .plain,
            target: self,
            action: #selector(showNewFormSheetView)
        )
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func bind() {
        bindcellItems()
        bindHeaderViewLabels()
        bindItemsSelected()
        bindItemsDeleted()
        bindLongPressGestures()
    }
    
    private func cell(
        at location: CGPoint,
        from tableView: UITableView
    ) -> TaskTableViewCell? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            return tableView.cellForRow(at: indexPath) as? TaskTableViewCell
        } else {
            return nil
        }
    }
    
    private func showPopoverView(at cell: TaskTableViewCell) {
        let popoverWidth = mainView.frame.size.width * Constants.popoverWidthRatio
        let popoverHeight = mainView.frame.size.height * Constants.popoverHeightRatio
        
        let popoverViewController = PopoverViewController()
        popoverViewController.task = cell.task
        popoverViewController.setPopoverAction()
        popoverViewController.delegate = self
        popoverViewController.preferredContentSize = .init(
            width: popoverWidth,
            height: popoverHeight
        )
        popoverViewController.modalPresentationStyle = .popover
        
        guard let popoverPresentationController = popoverViewController.popoverPresentationController else {
            return
        }
        
        popoverPresentationController.sourceView = cell
        popoverPresentationController.sourceRect = cell.bounds
        popoverPresentationController.permittedArrowDirections = .up
        
        present(popoverViewController, animated: true)
    }
    
    @objc private func showNewFormSheetView() {
        let newTodoViewContrtoller = NewFormSheetViewController()
        newTodoViewContrtoller.delegate = self
        let newTodoFormSheet = UINavigationController(
            rootViewController: newTodoViewContrtoller
        )
        newTodoFormSheet.modalPresentationStyle = .formSheet
        present(newTodoFormSheet, animated: true)
    }
    
    private func showEditFormSheetView(task: Task) {
        let editViewController = EditFormSheetViewController()
        editViewController.delegate = self
        editViewController.task = task
        let editFormSheet = UINavigationController(
            rootViewController: editViewController
        )
        editFormSheet.modalPresentationStyle = .formSheet
        present(editFormSheet, animated: true)
    }
}

// MARK: - bind Funciton

extension MainViewController {
    
    private func bindcellItems() {
        viewModel.todos
            .bind(to: mainView.todoTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.todos.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.doings
            .bind(to: mainView.doingTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.doings.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.dones
            .bind(to: mainView.doneTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.dones.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func bindHeaderViewLabels() {
        viewModel.todos
            .map { String($0.count) }
            .bind(to: mainView.todoHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.doings
            .map { String($0.count) }
            .bind(to: mainView.doingHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dones
            .map { String($0.count) }
            .bind(to: mainView.doneHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindItemsSelected() {
        mainView.todoTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.todoTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.todos.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.doingTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.doingTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.doings.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.doneTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.mainView.doneTableView.deselectRow(
                    at: indexPath,
                    animated: true
                )
                if let task = self?.viewModel.dones.value[indexPath.row] {
                    self?.showEditFormSheetView(task: task)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func bindItemsDeleted() {
        mainView.todoTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.cellItemDeleted(at: indexPath, taskType: .todo)
            })
            .disposed(by: disposeBag)
        
        mainView.doingTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.cellItemDeleted(at: indexPath, taskType: .doing)
            })
            .disposed(by: disposeBag)
        
        mainView.doneTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.cellItemDeleted(at: indexPath, taskType: .done)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindLongPressGestures() {
        mainView.todoTableView.rx.longPressGesture()
            .when(.began)
            .map { $0.location(in: self.mainView.todoTableView) }
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                guard let cell = self.cell(at: $0, from: self.mainView.todoTableView) else {
                    return
                }
                self.showPopoverView(at: cell)
            })
            .disposed(by: disposeBag)
        
        mainView.doingTableView.rx.longPressGesture()
            .when(.began)
            .map { $0.location(in: self.mainView.doingTableView) }
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                guard let cell = self.cell(at: $0, from: self.mainView.doingTableView) else {
                    return
                }
                self.showPopoverView(at: cell)
            })
            .disposed(by: disposeBag)
        
        mainView.doneTableView.rx.longPressGesture()
            .when(.began)
            .map { $0.location(in: self.mainView.doneTableView) }
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                guard let cell = self.cell(at: $0, from: self.mainView.doneTableView) else {
                    return
                }
                self.showPopoverView(at: cell)
            })
            .disposed(by: disposeBag)
    }
}

extension MainViewController: DataReloadable {
    func reloadData() {
        viewModel.fetchData()
    }
}

protocol DataReloadable: NSObject {
    func reloadData()
}
