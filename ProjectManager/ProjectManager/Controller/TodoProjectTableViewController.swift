//
//  TodoProjectTableViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

enum Section {
    case main
}

class TodoProjectTableViewController: UIViewController {
    
    // MARK: - Property
    weak var projectManager: ProjectManager?
    private let projectTableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section,Project>!
    
    // MARK: - View Life Cycle
    override func loadView() {
        self.configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.configureTableView()
        self.configureLayout()
        self.configureDataSource()
        self.applySnapshot()
    }
    
    // MARK: - Configure UI
    private func configureView() {
        self.view = .init()
        self.view.backgroundColor = .systemGray6
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTableView() {
        projectTableView.register(cellWithClass: ProjectTableViewCell.self)
        projectTableView.translatesAutoresizingMaskIntoConstraints = false
        projectTableView.backgroundColor = .clear
        projectTableView.separatorStyle = .none
    }
    
    private func configureLayout() {
        self.view.addSubview(projectTableView)
        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            projectTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            projectTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            projectTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            projectTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    // MARK: - TableView
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Project>(tableView: projectTableView) { (tableView: UITableView, indexPath: IndexPath, project: Project) -> UITableViewCell? in
            let projectCell = self.projectTableView.dequeueReusableCell(withClass: ProjectTableViewCell.self, for: indexPath)
            projectCell.updateContent(title: project.title,
                                      description: project.description,
                                      deadline: project.deadline?.description,
                                      with: project.isExpired ? .red : .black)
            return projectCell
        }
    }
    
    func applySnapshot() {
        let projects = projectManager?.readProject(of: .todo)
        
        guard let projects = projects else {
            return
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Project>()
        snapShot.appendSections([.main])
        snapShot.appendItems(projects, toSection: .main)
        
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
    }
}
