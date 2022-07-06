//
//  MainView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import UIKit

final class MainView: UIView {
    let todoHeaderView = WorkHeaderView(workType: .todo)
    let doingHeaderView = WorkHeaderView(workType: .doing)
    let doneHeaderView = WorkHeaderView(workType: .done)
    private lazy var baseStackView = UIStackView(
        arrangedSubviews: [
            todoStackView,
            doingStackView,
            doneStackView
        ]
    ).then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    private lazy var todoStackView = UIStackView(arrangedSubviews: [
        todoHeaderView,
        todoTableView
    ]).then {
        $0.axis = .vertical
    }
    
    private lazy var doingStackView = UIStackView(arrangedSubviews: [
        doingHeaderView,
        doingTableView
    ]).then {
        $0.axis = .vertical
    }
    
    private lazy var doneStackView = UIStackView(arrangedSubviews: [
        doneHeaderView,
        doneTableView
    ]).then {
        $0.axis = .vertical
    }
    
    lazy var todoTableView = UITableView()
    lazy var doingTableView = UITableView()
    lazy var doneTableView = UITableView()
    
    func setupSubViews() {
        addSubview(baseStackView)
        backgroundColor = .systemGray4
    }
    
    func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        todoHeaderView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        doingHeaderView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        doneHeaderView.snp.makeConstraints {
            $0.height.equalTo(80)
        }
        
    }
}
