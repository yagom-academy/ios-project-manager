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
    private let viewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    
    init() {
        self.todoView = UITableView()
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
        self.view.addSubview(self.todoView)
        self.todoView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.identifier)
        self.todoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.todoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.todoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.todoView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.todoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
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
    }
}
