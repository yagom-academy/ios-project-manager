//
//  TaskTableView.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/14.
//

import UIKit
import SnapKit

final class TaskSectionView: UIView {
    
    private(set) var taskType: TaskType
    private let baseStackView = UIStackView().then {
        $0.axis = .vertical
    }
    private(set) lazy var taskHeaderView = TaskHeaderView(taskType: taskType)
    private(set) var taskTableView = UITableView().then {
        $0.backgroundColor = .systemGray6
        $0.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: TaskTableViewCell.identifier
        )
    }
    
    init(taskType: TaskType) {
        self.taskType = taskType
        super.init(frame: .zero)
        setupSubViews()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(baseStackView)
        
        baseStackView.addArrangedSubview(taskHeaderView)
        baseStackView.addArrangedSubview(taskTableView)
    }
    
    private func setupUILayout() {
        baseStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let baseStackViewHeight = baseStackView.snp.height
        taskHeaderView.snp.makeConstraints {
            $0.height.equalTo(baseStackViewHeight).multipliedBy(0.1)
        }
    }
}
