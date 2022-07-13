//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit

import SnapKit

final class TodoListView: UIView {
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    private let todoView = TodoView(processType: .todo)
    private let doingView = TodoView(processType: .doing)
    private let doneView = TodoView(processType: .done)
    
    init() {
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
