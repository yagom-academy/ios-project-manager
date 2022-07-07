//
//  MainView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class MainView: UIView {
    private let todoHeaderView = TaskHeaderView(taskType: .todo)
    private let doingHeaderView = TaskHeaderView(taskType: .doing)
    private let doneHeaderView = TaskHeaderView(taskType: .done)
    
    lazy var todoTableView = UITableView()
    lazy var doingTableView = UITableView()
    lazy var doneTableView = UITableView()
    
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

    func setupSubViews() {
        addSubview(baseStackView)
        backgroundColor = .systemGray5
    }
    
    func setupUILayout() {
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
}
