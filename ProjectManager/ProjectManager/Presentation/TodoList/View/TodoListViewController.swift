//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TodoListViewController: UIViewController {
    private let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    
    private let mainView = TodoListView()
    private let viewModel: TodoListViewModel
    
    private let bag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavigationBar()
        bind()
    }
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
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
        title = "Project Manager"
        navigationItem.rightBarButtonItem = plusButton
    }
}

//MARK: - ViewModel Bind
extension TodoListViewController {
    private func bind() {
        
        //MARK: - TodoList
        viewModel.todoList
            .bind(to: mainView.todoTableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)
        
        viewModel.todoListCount
            .drive(mainView.todoHeaderView.rx.countText)
            .disposed(by: bag)
        
        Observable.zip(mainView.todoTableView.rx.modelSelected(TodoCellContent.self),
                                 mainView.todoTableView.rx.itemSelected)
        .bind(onNext: { [weak self] (item, indexPath) in
            self?.mainView.todoTableView.deselectRow(at: indexPath, animated: true)
            self?.viewModel.cellSelected(id: item.id)
        }).disposed(by: bag)
        
        //MARK: - DoingList
        viewModel.doingList
            .bind(to: mainView.doingTableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)
        
        viewModel.doingListCount
            .drive(mainView.doingHeaderView.rx.countText)
            .disposed(by: bag)
        
        Observable.zip(mainView.doingTableView.rx.modelSelected(TodoCellContent.self),
                                 mainView.doingTableView.rx.itemSelected)
        .bind(onNext: { [weak self] (item, indexPath) in
            self?.mainView.doingTableView.deselectRow(at: indexPath, animated: true)
            self?.viewModel.cellSelected(id: item.id)
        }).disposed(by: bag)
        
        //MARK: - DoneList
        viewModel.doneList
            .bind(to: mainView.doneTableView.rx.items(cellIdentifier: TodoListCell.identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.setContent(item: item)
              }.disposed(by: bag)

        viewModel.doneListCount
            .drive(mainView.doneHeaderView.rx.countText)
            .disposed(by: bag)
        
        Observable.zip(mainView.doneTableView.rx.modelSelected(TodoCellContent.self),
                                 mainView.doneTableView.rx.itemSelected)
        .bind(onNext: { [weak self] (item, indexPath) in
            self?.mainView.doneTableView.deselectRow(at: indexPath, animated: true)
            self?.viewModel.cellSelected(id: item.id)
        }).disposed(by: bag)
        
        //MARK: - Button
        plusButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.plusButtonDidTap()
            }.disposed(by: bag)
    }
}

