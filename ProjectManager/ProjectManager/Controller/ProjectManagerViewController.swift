//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class ProjectManagerViewController: UIViewController {
    private var projects = Projects.shared
    
    private let projectManagerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureProjectManagerCollectionView()
        configureConstraint()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray6
        title = "Project Manager"
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        navigationItem.rightBarButtonItem = addProjectButton
        
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }
    
    @objc
    private func addProject() {
        let detailProjectViewController = DetailProjectViewController()
        detailProjectViewController.configureEditingStatus(isEditible: true)
        
        detailProjectViewController.dismissHandler = { project in
            self.projects.list.append(project)
            self.todoTableView.reloadData()
            self.doingTableView.reloadData()
            self.doneTableView.reloadData()
        }
        
        let navigationController = UINavigationController(rootViewController: detailProjectViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationController, animated: true, completion: nil)
    }
    
    private func configureProjectManagerCollectionView() {
        view.addSubview(projectManagerStackView)
        projectManagerStackView.addArrangedSubview(todoTableView)
        projectManagerStackView.addArrangedSubview(doingTableView)
        projectManagerStackView.addArrangedSubview(doneTableView)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            projectManagerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectManagerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ProjectManagerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let index = projectManagerStackView.arrangedSubviews.firstIndex(of: tableView),
              let status = Status(rawValue: index) else { return 0 }
        return projects.list.filter { $0.status == status }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as? ProjectCell else { return ProjectCell() }
        
        guard let index = projectManagerStackView.arrangedSubviews.firstIndex(of: tableView),
              let status = Status(rawValue: index) else { return ProjectCell() }
        
        let assignedProjects = projects.list.filter { $0.status == status }
        let sortedAssignedProjects = assignedProjects.sorted { $0.date > $1.date }
        let project = sortedAssignedProjects[indexPath.row]
        let date = project.date.formatDate()
        
        cell.configureContent(title: project.title, body: project.body, date: date)
        
        if date < Date().formatDate() {
            cell.changeDateColor(isOverdue: true)
        } else {
            cell.changeDateColor(isOverdue: false)
        }
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        
        return cell
    }
}
