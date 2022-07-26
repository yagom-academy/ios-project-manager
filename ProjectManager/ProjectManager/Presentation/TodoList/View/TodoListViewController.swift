//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol TodoListViewControllerDependencies: AnyObject {
    func presentEditViewController(item: TodoModel?)
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel)
    func popoverHistoryViewController(button: UIBarButtonItem)
    func showErrorAlert(message: String)
}

final class TodoListViewController: UIViewController {
    private enum Constant {
        static let navigationBarTitle = "Project Manager"
    }
    
    private let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private let historyButton = UIBarButtonItem()
    
    private let mainView = TodoListView()
    private let viewModel: TodoListViewModel
    private weak var coordinator: TodoListViewControllerDependencies?
    
    private let bag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        bind()
    }
    
    init(viewModel: TodoListViewModel, coordinator: TodoListViewControllerDependencies?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension TodoListViewController {
    private func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureNavigationBar() {
        title = Constant.navigationBarTitle
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = historyButton
        historyButton.title = "History"
    }
}

//MARK: - ViewModel Bind
extension TodoListViewController {
    private func bind() {
        
        //MARK: - TodoList
        viewModel.todoList
            .bind(to: mainView.todo.tableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)
        
        viewModel.todoListCount
            .drive(mainView.todo.headerView.rx.countText)
            .disposed(by: bag)
        
        //MARK: - DoingList
        viewModel.doingList
            .bind(to: mainView.doing.tableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)
        
        viewModel.doingListCount
            .drive(mainView.doing.headerView.rx.countText)
            .disposed(by: bag)

        //MARK: - DoneList
        viewModel.doneList
            .bind(to: mainView.done.tableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)

        viewModel.doneListCount
            .drive(mainView.done.headerView.rx.countText)
            .disposed(by: bag)
        
        //MARK: - Event
        plusButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.presentEditViewController(item: nil)
            }.disposed(by: bag)
        
        historyButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.coordinator?.popoverHistoryViewController(button: self.historyButton)
            }.disposed(by: bag)
        
        Observable
            .of(mainView.todo.tableView.rx.listLongPress(TodoCellContent.self),
                mainView.doing.tableView.rx.listLongPress(TodoCellContent.self),
                mainView.done.tableView.rx.listLongPress(TodoCellContent.self))
            .merge()
            .bind { [weak self] (cell, item) in
                guard let item = self?.viewModel.cellSelected(id: item.id) else { return }
                self?.coordinator?.popoverMoveViewController(cell: cell, item: item)
            }.disposed(by: bag)
        
        Observable
            .of(mainView.todo.tableView.rx.listItemSelected(TodoCellContent.self),
                mainView.doing.tableView.rx.listItemSelected(TodoCellContent.self),
                mainView.done.tableView.rx.listItemSelected(TodoCellContent.self))
            .merge()
            .bind { [weak self] (indexPath, item) in
                self?.mainView.tableViewdeselectRow(indexPath: indexPath)
                let item = self?.viewModel.cellSelected(id: item.id)
                self?.coordinator?.presentEditViewController(item: item)
            }.disposed(by: bag)
        
        Observable
            .of(mainView.todo.tableView.rx.modelDeleted(TodoCellContent.self),
                mainView.doing.tableView.rx.modelDeleted(TodoCellContent.self),
                mainView.done.tableView.rx.modelDeleted(TodoCellContent.self))
            .merge()
            .bind { [weak self] item in
                self?.viewModel.cellDeleteButtonDidTap(item: item)
            }.disposed(by: bag)
        
        //MARK: - Error Handling
        viewModel.errorMessage
            .bind { [weak self] message in
                self?.coordinator?.showErrorAlert(message: message)
            }.disposed(by: bag)
    }
}
