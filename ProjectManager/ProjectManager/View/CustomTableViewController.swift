//
//  CustomTableViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/23.
//

import UIKit

class CustomTableViewController: UIViewController {
    let listViewModel: ListViewModel
    let state: State
    
    private let projectTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(CustomTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: CustomTableViewHeader.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
   
    init(listViewModel: ListViewModel, state: State) {
        self.listViewModel = listViewModel
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        view.addSubview(projectTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            projectTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDelegate() {
        projectTableView.delegate = self
        projectTableView.dataSource = self
    }
    
    private func configureViewModel() {
        switch state {
        case .todo:
            listViewModel.todoList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        case .doing:
            listViewModel.doingList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        case .done:
            listViewModel.doneList.bind { viewModel in
                self.projectTableView.reloadData()
            }
        }
    }
}

extension CustomTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .todo:
            return listViewModel.countProject(in: .todo)
        case .doing:
            return listViewModel.countProject(in: .doing)
        case .done:
            return listViewModel.countProject(in: .done)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else { return TableViewCell() }

        switch state {
        case .todo:
            let project = listViewModel.fetchProject(with: .todo, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            
            return cell
        case .doing:
            let project = listViewModel.fetchProject(with: .doing, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            return cell
        case .done:
            let project = listViewModel.fetchProject(with: .done, index: indexPath.row)
            listViewModel.configureCell(to: cell, with: project)
            
            return cell
            
        }
    }
}

extension CustomTableViewController: UITableViewDelegate {
 
}

