//
//  TodoProjectTableViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

// MARK: - TodoProjectTableViewControllerDelegate
protocol TodoProjectTableViewControllerDelegate {
    
    func update(of identifier: UUID, with content: [String: Any])
}

// MARK: - TodoProjectTableViewController
class TodoProjectTableViewController: UIViewController {
    
    // MARK: - DiffableDataSource Identfier
    enum Section {
        case main
    }
    
    // MARK: - Property
    weak var projectManager: ProjectManager?
    private let projectTableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section,Project>!
    private let longPressGestureRecognizer = UILongPressGestureRecognizer()
    weak var delegate: ProjectBoardViewController?
    
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
    
    // MARK: - Configure View
    private func configureView() {
        self.view = .init()
        self.view.backgroundColor = .systemGray6
        self.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTableView() {
        projectTableView.delegate = self
        projectTableView.register(headerFooterViewClassWith: ProjectTableViewHeaderView.self)
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
                                      deadline: project.deadline?.localeString(),
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
    
    func delegateUpdateProject(of identifier: UUID, with content: [String: Any]) {
        delegate?.updateProject(of: identifier, with: content)
    }
}

// MARK: - UITableViewDelegate
extension TodoProjectTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = projectTableView.dequeueReusableHeaderFooterView(
            withClass: ProjectTableViewHeaderView.self)
        
        let snapshot = dataSource.snapshot()
        let projectCount = snapshot.numberOfItems(inSection: .main)
        
        header.configureContent(status: String(describing: Status.todo),
                                projectCount: String(projectCount))
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedProject = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        let detailViewController = ProjectDetailViewController()
        detailViewController.modalPresentationStyle = .formSheet
        detailViewController.project = selectedProject
        
        self.present(detailViewController, animated: false, completion: nil)
    }
}
