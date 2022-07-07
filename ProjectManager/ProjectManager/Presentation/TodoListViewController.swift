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
    private let mainView = TodoListView()
    private let viewModel: TodoListViewModel
    
    private let bag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Project Manager"
        configureView()
        configureTableViewCell()
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
    
    private func configureTableViewCell() {
        mainView.todoTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.Identifier)
        mainView.doingTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.Identifier)
        mainView.doneTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.Identifier)
    }
}

//MARK: - ViewModel Bind
extension TodoListViewController {
    private func bind() {
        viewModel.todoList
            .do(onNext: { [weak self] in
                self?.mainView.todoHeaderView.countLabel.text = "\($0.count)"
            })
            .bind(to: mainView.todoTableView.rx.items(cellIdentifier: TodoListCell.Identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.deadlineLabel.text = item.deadlineAt.toString
              }.disposed(by: bag)
        
        viewModel.doingList
            .do(onNext: { [weak self] in
                self?.mainView.doingHeaderView.countLabel.text = "\($0.count)"
            })
            .bind(to: mainView.doingTableView.rx.items(cellIdentifier: TodoListCell.Identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.deadlineLabel.text = item.deadlineAt.toString
              }.disposed(by: bag)
        
        viewModel.doneList
            .do(onNext: { [weak self] in
                self?.mainView.doneHeaderView.countLabel.text = "\($0.count)"
            })
            .bind(to: mainView.doneTableView.rx.items(cellIdentifier: TodoListCell.Identifier,
                                                      cellType: TodoListCell.self)) { row, item, cell in
                cell.titleLabel.text = item.title
                cell.bodyLabel.text = item.body
                cell.deadlineLabel.text = item.deadlineAt.toString
              }.disposed(by: bag)
    }
}

