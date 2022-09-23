//
//  ProjectManagerView.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/09.
//

import UIKit
import RxSwift
import RxCocoa

final class TodoListView: UIView {
    private let registTableView: UITableView
    private let todoStatus: TodoCategory
    private let todoListViewModel: TodoListViewModel
    private let disposeBag = DisposeBag()
    private var coordinator: ApplyCoordinator?
    
    private let todoHeaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    
    private let todoHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var todoCircleNumber: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.backgroundColor = .label
        label.sizeToFit()
        label.text = "5"
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 17
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var todoTitleLabel: UILabel = {
        let todoLabel = UILabel()
        todoLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        todoLabel.text = self.todoStatus.value
        return todoLabel
    }()
    
    private let todoVerticalStackView: UIStackView = {
        let todoVerticalStackView = UIStackView()
        todoVerticalStackView.axis = .vertical
        todoVerticalStackView.alignment = .fill
        todoVerticalStackView.distribution = .fill
        todoVerticalStackView.spacing = 5
        todoVerticalStackView.backgroundColor = .systemGray6
        todoVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return todoVerticalStackView
    }()
    
    init(todoStatus: TodoCategory, todoListViewModel: TodoListViewModel, coordinator: ApplyCoordinator) {
        self.todoStatus = todoStatus
        self.registTableView = UITableView()
        self.todoListViewModel = todoListViewModel
        self.coordinator = coordinator
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.fetchTodoListCell()
        self.commonInit()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
}

extension TodoListView {
    private func commonInit() {
        self.addSubview()
        self.setupConstraint()
    }
    
    private func addSubview() {
        self.todoHeaderView.addSubview(self.todoHeaderStackView)
        self.todoHeaderStackView.addArrangedSubview(self.todoTitleLabel)
        self.todoHeaderStackView.addArrangedSubview(self.todoCircleNumber)
        self.todoVerticalStackView.addArrangedSubview(self.todoHeaderView)
        self.todoVerticalStackView.addArrangedSubview(self.registTableView)
        self.addSubview(self.todoVerticalStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.todoHeaderStackView.leadingAnchor.constraint(equalTo: self.todoHeaderView.leadingAnchor, constant: 10),
            self.todoHeaderStackView.topAnchor.constraint(equalTo: self.todoHeaderView.topAnchor, constant: 10),
            self.todoHeaderStackView.bottomAnchor.constraint(equalTo: self.todoHeaderView.bottomAnchor, constant: -10),
            
            self.todoVerticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.todoVerticalStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.todoVerticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.todoVerticalStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.todoCircleNumber.widthAnchor.constraint(equalTo: self.todoCircleNumber.heightAnchor)
        ])
    }
    
    private func fetchTodoListCell() {
        self.registTableView.register(TodoListCell.self, forCellReuseIdentifier: TodoListCell.reuseIdentifier)
    }
}
