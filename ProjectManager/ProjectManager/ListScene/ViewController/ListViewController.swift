//
//  ListViewController.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/18.
//

import UIKit

final class ListViewController: UIViewController {
    
    private var todoCollectionView: UICollectionView?
    
    private var datasource: UICollectionViewDiffableDataSource<TaskState, Task>?
    private var snapshot = NSDiffableDataSourceSnapshot<TaskState, Task>()
    private let viewModel: ListViewModel
    
    init(taskState: TaskState) {
        self.viewModel = ListViewModel(taskState: taskState)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewUI()
        configureCollectionViewUI()
        configureDatasource()
        applySnapshot()
        configureObserver()
    }
    
    func appendTasks(_ tasks: [Task]) {
        viewModel.tasks = tasks
    }
    
    private func makeParentViewController() -> MainViewController? {
        guard let parentVC = self.parent as? MainViewController else { return nil }
        
        return parentVC
    }
    
    private func configureObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applySnapshot),
                                               name: .updatedTask,
                                               object: nil)
    }

    @objc private func applySnapshot() {
        deleteSnapshotBySection()
        
        snapshot.appendSections([viewModel.taskState])
        snapshot.appendItems(viewModel.tasks)
        
        datasource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func deleteSnapshotBySection() {
        snapshot.deleteSections([viewModel.taskState])
        
        datasource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func makeAction(_ task: Task) -> [UIAction] {
        let parentVC = makeParentViewController()
        let todoAction = UIAction(title: "Move To Todo") { _ in
            self.viewModel.postChangedTaskState(by: parentVC, task: task, state: .todo)
        }
        let doingAction = UIAction(title: "Move To Doing") { _ in
            self.viewModel.postChangedTaskState(by: parentVC, task: task, state: .doing)
        }
        let doneAction = UIAction(title: "Move To Done") { _ in
            self.viewModel.postChangedTaskState(by: parentVC, task: task, state: .done)
        }
        
        switch viewModel.taskState {
        case .todo:
            return [doingAction, doneAction]
        case .doing:
            return [todoAction, doneAction]
        case .done:
            return [doingAction, doneAction]
        }
    }
}

// MARK: Delegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        
        let task = viewModel.tasks[indexPath.row]
        let actions = makeAction(task)
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            return UIMenu(options: .displayInline, children: actions)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let parentVC = makeParentViewController()
        let task = viewModel.tasks[indexPath.row]
        
        parentVC?.presentTodoViewController(.edit, task)
    }
}

// MARK: Datasource
extension ListViewController {
    private func configureDatasource() {
        guard let collectionView = todoCollectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<TaskListCell, Task> { cell, indexPath, itemIdentifier in
            cell.updateText(by: itemIdentifier)
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<TaskHeaderView>(elementKind: TaskHeaderView.identifier) { supplementaryView, elementKind, indexPath in
            supplementaryView.updateText(by: self.viewModel.taskState, number: self.snapshot.numberOfItems)
        }
        
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        datasource?.supplementaryViewProvider = { (view, kind, index) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
        }
        
        todoCollectionView?.dataSource = datasource
    }
}

// MARK: UI
extension ListViewController {
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            var listConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            
            listConfig.trailingSwipeActionsConfigurationProvider = { indexPath in
                let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
                    let task = self.viewModel.tasks[indexPath.row]
                    let parentVC = self.makeParentViewController()
                    
                    self.viewModel.postDeleteTask(by: parentVC, task: task)
                    
                    completion(true)
                }
                
                deleteAction.backgroundColor = .systemRed
                
                return UISwipeActionsConfiguration(actions: [deleteAction])
            }
            
            let section = NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnvironment)
            let headerViewSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .estimated(100))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerViewSize, elementKind: TaskHeaderView.identifier, alignment: .top)
            
            section.interGroupSpacing = 10
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
    
    private func configureCollectionViewUI() {
        let layout = makeCollectionViewLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        todoCollectionView = collectionView
        todoCollectionView?.delegate = self
    }
}
