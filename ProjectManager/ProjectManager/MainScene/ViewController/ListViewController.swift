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
        configureGesture()
        configureDatasource()
        applySnapshot(by: [])
    }
    
    func appendTask(_ task: [Task]) {
        viewModel.tasks = task
        
        applySnapshot(by: viewModel.tasks)
    }

    private func applySnapshot(by items: [Task]) {
        deleteSnapshotBySection()
        
        snapshot.appendSections([viewModel.taskState])
        snapshot.appendItems(items)
        
        datasource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteSnapshotBySection() {
        snapshot.deleteSections([viewModel.taskState])
        
        datasource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func deleteSnapshot(by task: Task) {
        snapshot.deleteItems([task])
        
        datasource?.apply(snapshot)
    }
    
    private func makeAlertAction(_ task: Task) -> [UIAlertAction] {
        let todoAction = UIAlertAction(title: "Move To Todo", style: .default) { _ in
            self.deleteSnapshot(by: task)
            NotificationCenter.default.post(name: .changedTaskState, object: nil, userInfo: ["task": task, "state": TaskState.todo])
        }
        let doingAction = UIAlertAction(title: "Move To Doing", style: .default) { _ in
            self.deleteSnapshot(by: task)
            NotificationCenter.default.post(name: .changedTaskState, object: nil, userInfo: ["task": task, "state": TaskState.doing])
        }
        let doneAction = UIAlertAction(title: "Move To Done", style: .default) { _ in
            self.deleteSnapshot(by: task)
            NotificationCenter.default.post(name: .changedTaskState, object: nil, userInfo: ["task": task, "state": TaskState.done])
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
    
    @objc func didTapLongPress(gesture: UILongPressGestureRecognizer) {
        guard gesture.state != .began else { return }
        
        let point = gesture.location(in: self.view)
        let indexPath = todoCollectionView?.indexPathForItem(at: point)

        guard let index = indexPath?.row else { return }
        
        let task = viewModel.tasks[index]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actions = makeAlertAction(task)
        let popOverVC = alert.popoverPresentationController
        
        popOverVC?.sourceView = self.view
        popOverVC?.sourceRect = CGRect(origin: point, size: CGSize.zero)
        popOverVC?.permittedArrowDirections = .up
        
        actions.forEach { action in
            alert.addAction(action)
        }
        
        self.present(alert, animated: true)
    }
}

// MARK: CollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let parentVC = self.parent as? MainViewController else { return }
        let task = viewModel.tasks[indexPath.row]
        deleteSnapshot(by: task)
        parentVC.presentTodoViewController(.edit, task)
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
                    self.deleteSnapshot(by: task)
                    NotificationCenter.default.post(name: .deleteTask,
                                                    object: nil,
                                                    userInfo: ["task": task])
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
    
    private func configureGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didTapLongPress))
        
        gesture.minimumPressDuration = 0.5
        gesture.delaysTouchesBegan = true
        
        self.todoCollectionView?.addGestureRecognizer(gesture)
    }
}
