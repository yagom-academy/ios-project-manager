//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

import RxCocoa
import RxSwift

final class TodoListViewController: UIViewController {
    private var todoView: UITableView
    private var doingView: UITableView
    private var doneView: UITableView
    private let viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    
    private let todoListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .lightGray
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init() {
        self.todoView = UITableView()
        self.doingView = UITableView()
        self.doneView = UITableView()
        self.viewModel = TodoListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.setUpNavigation()
        self.bind()
    }
    
    private func setUpView() {
        self.todoView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        self.doingView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        self.doneView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        
        self.view.addSubview(self.todoListStackView)
        self.todoListStackView.addArrangedSubviews(with: [self.todoView, self.doingView, self.doneView])
        
        NSLayoutConstraint.activate([
            self.todoListStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.todoListStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.todoListStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.todoListStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpNavigation() {
        self.view.backgroundColor = .systemBackground
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: nil,
            action: nil)
    }
    
    private func bind() {
        self.viewModel.tableViewData?
            .bind(to: self.todoView.rx.items) { tabelView, row, element in
                guard let cell = tabelView.dequeueReusableCell(
                    withIdentifier: TodoListCell.identifier,
                    for: IndexPath(row: row, section: .zero)) as? TodoListCell
                else {
                    return UITableViewCell()
                }
                cell.configure(element)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        self.viewModel.tableViewData?
            .bind(to: self.doingView.rx.items) { tabelView, row, element in
                guard let cell = tabelView.dequeueReusableCell(
                    withIdentifier: TodoListCell.identifier,
                    for: IndexPath(row: row, section: .zero)) as? TodoListCell
                else {
                    return UITableViewCell()
                }
                cell.configure(element)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        self.viewModel.tableViewData?
            .bind(to: self.doneView.rx.items) { tabelView, row, element in
                guard let cell = tabelView.dequeueReusableCell(
                    withIdentifier: TodoListCell.identifier,
                    for: IndexPath(row: row, section: .zero)) as? TodoListCell
                else {
                    return UITableViewCell()
                }
                cell.configure(element)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
