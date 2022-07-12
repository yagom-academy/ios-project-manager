//
//  MainView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class MainView: UIView {
    
    private(set) lazy var todoHeaderView = TaskHeaderView(taskType: .todo)
    private(set) lazy var doingHeaderView = TaskHeaderView(taskType: .doing)
    private(set) lazy var doneHeaderView = TaskHeaderView(taskType: .done)
    
    private(set) lazy var todoTableView = generateTableView()
    private(set) lazy var doingTableView = generateTableView()
    private(set) lazy var doneTableView = generateTableView()
    
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            todoStackView,
            doingStackView,
            doneStackView
        ]).then {
            $0.axis = .horizontal
            $0.spacing = 15
            $0.distribution = .fillEqually
        }
    
    private lazy var todoStackView = UIStackView(
        arrangedSubviews: [
            todoHeaderView,
            todoTableView
        ]).then {
            $0.axis = .vertical
        }
    
    private lazy var doingStackView = UIStackView(
        arrangedSubviews: [
            doingHeaderView,
            doingTableView
        ]).then {
            $0.axis = .vertical
        }
    
    private lazy var doneStackView = UIStackView(
        arrangedSubviews: [
            doneHeaderView,
            doneTableView
        ]).then {
            $0.axis = .vertical
        }

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray5
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        let baseStackViewHeight = baseStackView.snp.height
        todoHeaderView.snp.makeConstraints {
            $0.height.equalTo(baseStackViewHeight).multipliedBy(0.1)
        }
        doingHeaderView.snp.makeConstraints {
            $0.height.equalTo(baseStackViewHeight).multipliedBy(0.1)
        }
        doneHeaderView.snp.makeConstraints {
            $0.height.equalTo(baseStackViewHeight).multipliedBy(0.1)
        }
    }
    
    private func generateTableView() -> UITableView {
        return UITableView().then {
            $0.backgroundColor = .systemGray6
            $0.register(
                TaskTableViewCell.self,
                forCellReuseIdentifier: TaskTableViewCell.identifier
            )
        }
    }
}
