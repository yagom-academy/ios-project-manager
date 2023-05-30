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
        stackView.backgroundColor = .systemGray4
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "ProjectCell")
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.backgroundColor = .systemGray5
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubview()
        configureConstraint()
        configureLongGestureRecognizer()
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
        
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
    }
    
    @objc
    private func addProject() {
        let detailProjectViewController = DetailProjectViewController()
        detailProjectViewController.configureEditingStatus(isEditible: true)
        
        detailProjectViewController.dismissHandler = { project in
            self.projects.list.append(project)
            self.todoTableView.reloadData()
        }
        
        let navigationController = UINavigationController(rootViewController: detailProjectViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationController, animated: true, completion: nil)
    }
    
    private func configureSubview() {
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
            projectManagerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        return cell
    }
}

extension ProjectManagerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView else { return HeaderView() }
        
        guard let index = projectManagerStackView.arrangedSubviews.firstIndex(of: tableView),
              let status = Status(rawValue: index) else { return HeaderView() }
        
        let assignedProjects = projects.list.filter { $0.status == status }
        let countText = assignedProjects.count > 99 ? "99+" : "\(assignedProjects.count)"
        headerView.configureContent(status: status, number: countText)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let index = projectManagerStackView.arrangedSubviews.firstIndex(of: tableView) else { return }
        
        guard let status = Status(rawValue: index) else { return }
        
        let assignedProjects = projects.list.filter { $0.status == status }
        let sortedAssignedProjects = assignedProjects.sorted { $0.date > $1.date }
        let project = sortedAssignedProjects[indexPath.row]
        
        let detailProjectViewController = DetailProjectViewController()
        detailProjectViewController.configureEditingStatus(isEditible: false)
        detailProjectViewController.configureProject(assignedProject: project)
        
        detailProjectViewController.dismissHandler = { project in
            guard let projectIndex = self.projects.list.firstIndex(where: { $0.id == project.id }) else { return }
            
            self.projects.list[projectIndex].title = project.title
            self.projects.list[projectIndex].body = project.body
            self.projects.list[projectIndex].date = project.date
            
            tableView.reloadData()
        }
        
        let navigationController = UINavigationController(rootViewController: detailProjectViewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { action, view, completionHandler in
            
            guard let index = self.projectManagerStackView.arrangedSubviews.firstIndex(of: tableView) else { return }
            
            guard let status = Status(rawValue: index) else { return }
            
            let assignedProjects = self.projects.list.filter { $0.status == status }
            let sortedAssignedProjects = assignedProjects.sorted { $0.date > $1.date }
            let projectToDelete = sortedAssignedProjects[indexPath.row]
            
            guard let removeIndex = self.projects.list.firstIndex(where: { $0.id == projectToDelete.id }) else { return }
            
            self.projects.list.remove(at: removeIndex)
            
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ProjectManagerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func configureLongGestureRecognizer() {
        [todoTableView, doingTableView, doneTableView].forEach { tableView in
            let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
            longPressedGesture.minimumPressDuration = 0.7
            longPressedGesture.delegate = self
            longPressedGesture.delaysTouchesBegan = true
            tableView.addGestureRecognizer(longPressedGesture)
        }
    }
    
    @objc
    private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let selectedTableView = gestureRecognizer.view as? UITableView else { return }
        
        let location = gestureRecognizer.location(in: selectedTableView)
        
        guard let indexPath = selectedTableView.indexPathForRow(at: location) else { return }
        
        guard let index = projectManagerStackView.arrangedSubviews.firstIndex(of: selectedTableView) else { return }
        
        guard let status = Status(rawValue: index) else { return }
        
        let assignedProjects = projects.list.filter { $0.status == status }
        let sortedAssignedProjects = assignedProjects.sorted { $0.date > $1.date }
        let project = sortedAssignedProjects[indexPath.row]
        let moveToViewController = MoveToViewController(project: project)
        moveToViewController.modalPresentationStyle = UIModalPresentationStyle.popover
        moveToViewController.preferredContentSize = CGSize(width: 300, height: 150)
        moveToViewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        moveToViewController.popoverPresentationController?.sourceView = selectedTableView.cellForRow(at: indexPath)
        
        moveToViewController.dismissHandler = { project, status in
            for index in 0...self.projects.list.count-1 {
                if self.projects.list[index].id == project.id {
                    self.projects.list[index].status = status
                }
            }
            
            self.todoTableView.reloadData()
            self.doingTableView.reloadData()
            self.doneTableView.reloadData()
        }
        
        present(moveToViewController, animated: true, completion: nil)
    }
}
