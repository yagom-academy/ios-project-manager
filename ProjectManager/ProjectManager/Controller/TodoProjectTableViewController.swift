//
//  TodoProjectTableViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/08.
//

import UIKit

// MARK: - TodoProjectTableViewController
class TodoProjectTableViewController: UIViewController {
    
    // MARK: - DiffableDataSource Identfier
    enum Section {
        case main
    }
    
    // MARK: - Property
    private let projectStatus = Status.todo
    private let projectTableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section,Project>!
    private let longPressGestureRecognizer = UILongPressGestureRecognizer()
    weak var delegate: ProjectTableViewControllerDelegate?
    
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
        self.setupLongGestureRecognizerOnTableView()
    }
    
    // MARK: - Configure View
    private func configureView() {
        self.view = .init()
        self.view.backgroundColor = .systemGray5
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
    
    // MARK: - Configure Controller
       private func setupLongGestureRecognizerOnTableView() {
           self.longPressGestureRecognizer.minimumPressDuration = 0.5
           self.longPressGestureRecognizer.delaysTouchesBegan = true

           self.projectTableView.addGestureRecognizer(longPressGestureRecognizer)
           self.longPressGestureRecognizer.addTarget(self, action: #selector(presentEditPopover))
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
        let projects = delegate?.readProject(of: projectStatus)
        
        guard let projects = projects else {
            return
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section, Project>()
        snapShot.appendSections([.main])
        snapShot.appendItems(projects, toSection: .main)
        
        dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
    }
    
    // MARK: - Method
    @objc func presentEditPopover() {
        let location = longPressGestureRecognizer.location(in: projectTableView)
        guard let project = longPressedProject(at: location),
              let identifier = project.identifier else {
            return
        }
        
        let actionSheetController = UIAlertController(title: nil,
                                                      message: nil,
                                                      preferredStyle: .actionSheet)
        let transitionToDoing = UIAlertAction(title: "move to \(String(describing: Status.doing))",
                                              style: .default) { [weak self] _ in
            self?.delegate?.updateProjectStatus(of: identifier, with: .doing)
            self?.applySnapshot()
        }
        let transitionToDone = UIAlertAction(title: "move to \(String(describing: Status.done))",
                                             style: .default) { [weak self] _ in
            self?.delegate?.updateProjectStatus(of: identifier, with: .done)
            self?.applySnapshot()
        }
        actionSheetController.addAction(transitionToDoing)
        actionSheetController.addAction(transitionToDone)
        
        if let popoverController = actionSheetController.popoverPresentationController {
            popoverController.sourceView = self.projectTableView
            popoverController.sourceRect = CGRect(origin: location, size: .zero)
        }
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    private func longPressedProject(at point: CGPoint) -> Project? {
        let CellIndexPath = projectTableView.indexPathForRow(at: point)
        guard let indexPath = CellIndexPath else {
            return nil
        }
        
        return self.dataSource.itemIdentifier(for: indexPath)
    }
}

// MARK: - UITableViewDelegate
extension TodoProjectTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = projectTableView.dequeueReusableHeaderFooterView(
            withClass: ProjectTableViewHeaderView.self)
        
        let snapshot = dataSource.snapshot()
        let projectCount = snapshot.numberOfItems(inSection: .main)
        
        header.configureContent(status: String(describing: projectStatus),
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
        detailViewController.delegate = self
        
        self.present(detailViewController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) {  [weak self] _, _, _ in
            guard let project = self?.dataSource.itemIdentifier(for: indexPath),
                  let identifier = project.identifier else {
                return
            }
            self?.delegate?.deleteProject(of: identifier)
            self?.applySnapshot()
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        let actionConfigurations = UISwipeActionsConfiguration(actions: [deleteAction])
        return actionConfigurations
    }
}

// MARK: - ProjectDetailViewControllerDelegate
extension TodoProjectTableViewController: ProjectDetailViewControllerDelegate {
    
    func delegateUpdateProject(of identifier: UUID, with content: [String: Any]) {
        delegate?.updateProject(of: identifier, with: content)
    }
}
