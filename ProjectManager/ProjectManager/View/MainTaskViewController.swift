//
//  ProjectManager - MainTaskViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainTaskViewController: UIViewController {
    let taskTableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let taskInWaitingTableView = TaskTableView(state: .waiting)
    let taskInProgressTableView = TaskTableView(state: .progress)
    let taskInDoneTableView = TaskTableView(state: .done)
    
    private var taskListViewModel: TaskViewModel
    
    init(taskListViewModel: TaskViewModel) {
        self.taskListViewModel = taskListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("스토리보드 사용하지 않음")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        taskListViewModel.didLoaded()
        navigationItem.title = "Project Manager"
    }
    
    private func configureUI() {
        [taskInWaitingTableView, taskInProgressTableView, taskInDoneTableView].forEach {
            taskTableStackView.addArrangedSubview($0)
        }
        
        view.addSubview(taskTableStackView)
        
        NSLayoutConstraint.activate([
            taskTableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            taskTableStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskTableView = tableView as? TaskTableView else {
            return .zero
        }
        
        switch taskTableView.state {
        case .waiting:
            return taskListViewModel.count(of: .waiting)
        case .progress:
            return taskListViewModel.count(of: .progress)
        case .done:
            return taskListViewModel.count(of: .done)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: TaskTableViewCell.self, for: indexPath)
        
        taskListViewModel.task(at: indexPath.row, from: .waiting)
        
        return TaskTableViewCell()
    }
}
