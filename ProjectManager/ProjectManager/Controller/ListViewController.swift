//
//  ListViewController.swift
//  ProjectManager
//
//  Created by Karen, Zion on 2023/10/03.
//

import UIKit

enum TaskStatus: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}

protocol ListViewControllerDelegate: AnyObject {
    func didTappedDoneButtonForUpdate(updateTask: Task)
    func didSwipedDeleteTask(_ deleteTask: Task)
    func moveCell(to moveToTaskStatus: TaskStatus, task: Task)
}

final class ListViewController: UIViewController, AlertControllerShowable {
    enum Section {
        case main
    }
    weak var delegate: ListViewControllerDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout())
        
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, Task>?
    
    private let taskStatus: TaskStatus
    
    private let useCase: ListViewControllerUseCaseType
    
    private var taskList: [Task] = []
    
    private var headerView: ListCollectionHeaderView?
    
    init(taskStatus: TaskStatus, useCase: ListViewControllerUseCaseType) {
        self.taskStatus = taskStatus
        self.useCase = useCase
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpConstraints()
        setUpViewController()
        setUpDiffableDataSource()
        setUpDiffableDataSourceHeader()
        setUpDiffableDataSourceSanpShot()
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - Diffable DataSource
extension ListViewController {
    func reloadTaskList(taskList: [Task]) {
        setUpDiffableDataSourceSanpShot(taskList: taskList)
        headerView?.setUpContents(title: taskStatus.rawValue, taskCount: "\(taskList.count)")
    }
    
    private func setUpDiffableDataSourceSanpShot(taskList: [Task] = []) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Task>()
        
        self.taskList = taskList
        snapShot.appendSections([.main])
        snapShot.appendItems(taskList)
        diffableDataSource?.apply(snapShot)
    }
    
    private func setUpDiffableDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, Task> { [weak self] cell, indexPath, task in
            guard let self = self else { return }
            let taskDTO  = self.useCase.convertTaskDTOFromTask(task: task)
            
            cell.delegate = self
            cell.setUpContents(taskDTO: taskDTO)
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, task in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: task)
        })
    }
    
    private func setUpDiffableDataSourceHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<ListCollectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] headerView, elementKind, indexPath in
            guard let self = self else { return }
            
            self.headerView = headerView
            headerView.setUpContents(title: self.taskStatus.rawValue, taskCount: "\(self.taskList.count)")
        }
        
        diffableDataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var listLayout = UICollectionLayoutListConfiguration(appearance: .grouped)
            
            listLayout.trailingSwipeActionsConfigurationProvider = { indexPath in
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, handler in
                    guard let self = self else { return }
                    
                    self.didSwipedDeleteTask(self.taskList[indexPath.row])
                }
                
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
            
            listLayout.headerMode = .supplementary

            let section = NSCollectionLayoutSection.list(using: listLayout, layoutEnvironment: layoutEnvironment)
            
            section.interGroupSpacing = 10
            return section
        }
    }
}

// MARK: - CollectionView Delegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        let taskViewController = TaskViewController(task: task, mode: .update)
        let navigationController = UINavigationController(rootViewController: taskViewController)
        
        taskViewController.delegate = self
        navigationController.modalPresentationStyle = .formSheet
        present(navigationController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - TaskViewController Delegate
extension ListViewController: TaskViewControllerDelegate {
    func didTappedDoneButton(task: Task) {
        delegate?.didTappedDoneButtonForUpdate(updateTask: task)
    }
    
    func didSwipedDeleteTask(_ deleteTask: Task) {
        delegate?.didSwipedDeleteTask(deleteTask)
    }
}

// MARK: - ListCollectionViewCell Delegate
extension ListViewController: ListCollectionViewCellDelegate {
    func didLongPressCell(taskDTO: TaskDTO, cellFrame: CGRect) {
        let (firstMoveAlertTitle, secondMoveAlerTitle) = convertAlertsTitle()
        let task = useCase.convertTaskFromTaskDTO(taskDTO: taskDTO)
        
        let firstMoveAlertAction: UIAlertAction = .init(title: firstMoveAlertTitle, style: .default) { action in
            switch self.taskStatus {
            case .todo:
                self.moveCell(to: .doing, task: task)
            case .doing, .done:
                self.moveCell(to: .todo, task: task)
            }
        }
        
        let secondMoveAlertAction: UIAlertAction = .init(title: secondMoveAlerTitle, style: .default) { action in
            switch self.taskStatus {
            case .todo, .doing:
                self.moveCell(to: .done, task: task)
            case .done:
                self.moveCell(to: .doing, task: task)
            }
        }
        
        showPopOverAlertController(sourceRect: cellFrame, alertActions: [firstMoveAlertAction, secondMoveAlertAction])
    }
    
    private func moveCell(to moveToTaskStatus: TaskStatus, task: Task) {
        delegate?.moveCell(to: moveToTaskStatus, task: task)
    }
    
    private func convertAlertsTitle() -> (String, String) {
        switch taskStatus {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
    }
}
