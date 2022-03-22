//
//  ProjectListViewController.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/15.
//

import UIKit


// MARK: - ProjectListViewController
final class ProjectListViewController: UIViewController {
    
    // MARK: - DiffableDataSource Identfier
    enum Section {
        case main
    }
    
    // MARK: - UI Property
    private let headerView = ProjectTableViewHeaderView()
    private let projectTableView = UITableView()
    
    // MARK: - Property
    var projectStatus: Status!
    private var dataSource: UITableViewDiffableDataSource<Section,Project>!
    private let longPressGestureRecognizer = UILongPressGestureRecognizer()
    weak var delegate: ProjectListViewControllerDelegate?
    
    // MARK: - Initializer
    init(status: Status) {
        self.projectStatus = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
        self.updateView()
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
        projectTableView.register(cellWithClass: ProjectTableViewCell.self)
        projectTableView.translatesAutoresizingMaskIntoConstraints = false
        projectTableView.backgroundColor = .clear
        projectTableView.separatorStyle = .none
    }
    
    private func configureLayout() {
        self.view.addSubview(headerView)
        self.view.addSubview(projectTableView)
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 60),
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: projectTableView.topAnchor)])
        
        NSLayoutConstraint.activate([
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
        self.longPressGestureRecognizer.addTarget(
            self,
            action: #selector(presentStatusModificationPopover)
        )
    }
    
    // MARK: - TableView Method
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Project>(
            tableView: projectTableView
        ) {
            (tableView: UITableView, indexPath: IndexPath, project: Project) -> UITableViewCell? in
            let projectCell = self.projectTableView.dequeueReusableCell(
                withClass: ProjectTableViewCell.self,
                for: indexPath
            )
            projectCell.updateContent(title: project.title,
                                      description: project.description,
                                      deadline: project.deadline?.localeString(),
                                      with: project.isExpired ? .red : .black)
            return projectCell
        }
    }
    
    func applySnapshotToCell() {
        self.delegate?.readProject(of: self.projectStatus) { [weak self] result in
            switch result {
            case .success(let projects):
                DispatchQueue.main.async {
                    var snapShot = NSDiffableDataSourceSnapshot<Section, Project>()
                    snapShot.appendSections([.main])
                    snapShot.appendItems(projects ?? [], toSection: .main)
                    
                    self?.dataSource.apply(snapShot, animatingDifferences: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                // TODO: - 사용자에게 알림 처리
            }
        }
    }
    
    // MARK: - Method
    func updateView() {
        applySnapshotToCell()
        updateHeaderView()
    }
    
    func updateHeaderView() {
        self.delegate?.readProject(of: self.projectStatus) {[weak self] result in
            switch result {
            case .success(let projects):
                DispatchQueue.main.async {
                    self?.headerView.configureContent(
                        status: String(describing: self?.projectStatus ?? .todo),
                        projectCount: projects?.count ?? .zero
                    )
                }
            case .failure(let error):
                print(error.localizedDescription)
                // TODO: - 사용자에게 알림 처리
            }
        }
    }
    
    @objc func presentStatusModificationPopover() {
        let location = longPressGestureRecognizer.location(in: projectTableView)
        guard let project = longPressedProject(at: location),
              let identifier = project.identifier else {
                  return
              }
        
        let actionSheetController = UIAlertController(title: nil,
                                                      message: nil,
                                                      preferredStyle: .actionSheet)
        let firstAction = firstStatusModificationPopoverUIAlertAction(with: identifier)
        let secondAction = secondStatusModificationPopoverUIAlertAction(with: identifier)
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        
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
    
    private func firstStatusModificationPopoverUIAlertAction(
        with identifier: String
    ) -> UIAlertAction {
        
        switch projectStatus {
        case .todo:
            let fisrtAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.doing.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .doing)
                self?.updateView()
            }
            return fisrtAction
        case .doing:
            let fisrtAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.todo.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .todo)
                self?.updateView()
            }
            return fisrtAction
        case .done:
            let fisrtAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.todo.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .todo)
                self?.updateView()
            }
            return fisrtAction
        case .none:
            return UIAlertAction()
        }
    }
    
    private func secondStatusModificationPopoverUIAlertAction(
        with identifier: String
    ) -> UIAlertAction {
        
        switch projectStatus {
        case .todo:
            let secondAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.done.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .done)
                self?.updateView()
            }
            return secondAction
        case .doing:
            let secondAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.done.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .done)
                self?.updateView()
            }
            return secondAction
        case .done:
            let secondAction = UIAlertAction(
                title: ProjectBoardScene.statusModification.doing.rawValue,
                style: .default
            ) { [weak self] _ in
                self?.delegate?.updateProjectStatus(of: identifier, with: .doing)
                self?.updateView()
            }
            return secondAction
        case .none:
            return UIAlertAction()
        }
    }
}

// MARK: - UITableViewDelegate
extension ProjectListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedProject = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        let detailViewController = ProjectViewController(mode: .edit,
                                                         project: selectedProject,
                                                         projectCreationDelegate: nil,
                                                         projectEditDelegate: self)
        detailViewController.modalPresentationStyle = .formSheet
        
        self.present(detailViewController, animated: false, completion: nil)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: nil
        ) {  [weak self] _, _, _ in
            guard let project = self?.dataSource.itemIdentifier(for: indexPath),
                  let identifier = project.identifier else {
                      return
                  }
            self?.delegate?.deleteProject(of: identifier)
            self?.updateView()
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        let actionConfigurations = UISwipeActionsConfiguration(actions: [deleteAction])
        return actionConfigurations
    }
}

// MARK: - ProjectEditViewControllerDelegate
extension ProjectListViewController: ProjectEditDelegate {
    
    func updateProject(of identifier: String, with content: [String: Any]) {
        delegate?.updateProject(of: identifier, with: content)
    }
}
