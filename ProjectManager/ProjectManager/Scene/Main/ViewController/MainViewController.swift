//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxRelay
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
        let titleLabel = UILabel().then {
            $0.text = Constants.title
            $0.font = .preferredFont(forTextStyle: .headline)
        }
        
        let networkIcon = UIView(frame: .zero).then {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 5
        }

        let baseStackView = UIStackView(arrangedSubviews: [titleLabel, networkIcon]).then {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 5
        }
        
        navigationItem.titleView = baseStackView
        networkIcon.snp.makeConstraints {
            $0.height.width.equalTo(titleLabel.snp.height).offset(-10)
        }
        
        let plusButton = UIBarButtonItem(
            image: UIImage(systemName: Constants.plus),
            style: .plain,
            target: self,
            action: #selector(showNewFormSheetView)
        )
        
        let historyButton = UIBarButtonItem(title: "History", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = historyButton
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func bind() {
        bindNetworkIconState()
        bindcellItems()
        bindHeaderViewLabels()
        bindItemsSelected()
        bindItemsDeleted()
        bindLongPressGestures()
        bindErrorAlert()
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
    
    private func bindNetworkIconState() {
        viewModel.network
            .map { bool in
                if bool {
                    return UIColor.systemGreen
                } else {
                    return UIColor.systemRed
                }
            }
            .bind(to: (navigationItem.titleView?.subviews[1].rx.backgroundColor)!)
            .disposed(by: disposeBag)
    }
    
    private func bindcellItems() {
        viewModel.todos
            .bind(to: mainView.todoView.taskTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.todos.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.doings
            .bind(to: mainView.doingView.taskTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.doings.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
        
        viewModel.dones
            .bind(to: mainView.doneView.taskTableView.rx.items(
                cellIdentifier: TaskTableViewCell.identifier,
                cellType: TaskTableViewCell.self)
            ) { [weak self] (row, _, cell) in
                if let task = self?.viewModel.dones.value[row] {
                    cell.setupContents(task: task)
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func bindErrorAlert() {
        viewModel.error
            .subscribe(onNext: { [weak self] error in
                self?.showAlert(message: error.errorDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func matchTaskType(taskType: TaskType) -> BehaviorRelay<[Task]> {
        switch taskType {
        case .todo:
            return self.viewModel.todos
        case .doing:
            return self.viewModel.doings
        case .done:
            return self.viewModel.dones
        }
    }
    
    private func bindHeaderViewLabels() {
        viewModel.todos
            .map { String($0.count) }
            .bind(to: mainView.todoView.taskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.doings
            .map { String($0.count) }
            .bind(to: mainView.doingView.taskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dones
            .map { String($0.count) }
            .bind(to: mainView.doneView.taskHeaderView.taskCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindItemsSelected() {
        [mainView.todoView, mainView.doingView, mainView.doneView].forEach {
            let section = $0
            let tableView = $0.taskTableView
            tableView.rx.itemSelected
                .subscribe(onNext: { [weak self, weak section, weak tableView] indexPath in
                    guard let section = section, let tableView = tableView else { return }
                    tableView.deselectRow(at: indexPath, animated: true)
                    if let task = self?.matchTaskType(
                        taskType: section.taskType
                    ).value[indexPath.row] {
                        self?.showEditFormSheetView(task: task)
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func bindItemsDeleted() {
        [mainView.todoView, mainView.doingView, mainView.doneView].forEach {
            let section = $0
            let tableView = $0.taskTableView
            tableView.rx.itemDeleted
                .subscribe(onNext: { [weak self, weak section] indexPath in
                    guard let section = section else { return }
                    self?.viewModel.cellItemDeleted(at: indexPath, taskType: section.taskType)
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func bindLongPressGestures() {
        [mainView.todoView, mainView.doingView, mainView.doneView].forEach {
            let tableView = $0.taskTableView
            tableView.rx.longPressGesture()
                .when(.began)
                .map { $0.location(in: tableView) }
                .subscribe(onNext: { [weak self, weak tableView] in
                    guard let self = self, let tableView = tableView else { return }
                    guard let cell = self.cell(at: $0, from: tableView) else { return }
                    self.showPopoverView(at: cell)
                })
                .disposed(by: disposeBag)
        }
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
