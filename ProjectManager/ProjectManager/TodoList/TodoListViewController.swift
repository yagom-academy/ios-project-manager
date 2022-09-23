//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class TodoListViewController: UIViewController {
    private let todoListView: TodoListView
    private let doingListView: TodoListView
    private let doneListView: TodoListView
    private var coordinator: ApplyCoordinator?
    private let realm = try! Realm()
    private let disposeBag = DisposeBag()
    
    private let todoTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray5
        return stackView
    }()
    
    init(todoListModelView: TodoListViewModel, coordinator: ApplyCoordinator) {
        self.todoListView = TodoListView(todoStatus: .todo, todoListViewModel: todoListModelView, coordinator: coordinator)
        self.doingListView = TodoListView(todoStatus: .doing, todoListViewModel: todoListModelView, coordinator: coordinator)
        self.doneListView = TodoListView(todoStatus: .done, todoListViewModel: todoListModelView, coordinator: coordinator)
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationBar()
        configureUI()
        setupConstraint()
        bind()
    }
}

extension TodoListViewController {
    private func addNavigationBar() {
        self.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
    }
    
    private func configureUI() {
        self.view.addSubview(self.todoTableStackView)
        self.todoTableStackView.addArrangedSubview(todoListView)
        self.todoTableStackView.addArrangedSubview(doingListView)
        self.todoTableStackView.addArrangedSubview(doneListView)
    }
    
    private func setupConstraint() {
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            self.todoTableStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.todoTableStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.todoTableStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.todoTableStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        self.navigationItem.rightBarButtonItem?.rx.tap.asObservable()
            .subscribe({ result in
                switch result {
                case .next:
                    self.coordinator?.passAwayTodoDetailView(detailType: .newTodo, categoryType: .todo)
                    
                case let .error(err):
                    print(err.localizedDescription)
                case .completed:
                    print("Complete")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
