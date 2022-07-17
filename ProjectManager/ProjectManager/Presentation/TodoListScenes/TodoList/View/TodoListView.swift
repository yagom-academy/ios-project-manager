//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

import SnapKit

final class TodoListView: UIView {
    private let todoView: TodoView
    private let doingView: TodoView
    private let doneView: TodoView
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    init(factory: ViewControllerFactory) {
        self.todoView = factory.makeTodoView(processType: .todo)
        self.doingView = factory.makeTodoView(processType: .doing)
        self.doneView = factory.makeTodoView(processType: .done)
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
    }
    
    private func addSubviews() {
        addSubview(tableStackView)
        tableStackView.addArrangeSubviews(todoView, doingView, doneView)
    }
    
    private func setupConstraint() {
        tableStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
}
