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
    
    private let baseStackView = UIStackView().then {
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
    private let todoStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let doingStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    private let doneStackView = UIStackView().then {
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
        
        baseStackView.addArrangedSubview(todoStackView)
        baseStackView.addArrangedSubview(doingStackView)
        baseStackView.addArrangedSubview(doneStackView)
    
        todoStackView.addArrangedSubview(todoHeaderView)
        todoStackView.addArrangedSubview(todoTableView)

        doingStackView.addArrangedSubview(doingHeaderView)
        doingStackView.addArrangedSubview(doingTableView)

        doneStackView.addArrangedSubview(doneHeaderView)
        doneStackView.addArrangedSubview(doneTableView)
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
