//
//  TaskCollectionViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/25.
//

import UIKit
import Combine

final class TaskCollectionViewController: UIViewController  {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkState, Task.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkState, Task.ID>
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    
    var dataSource: DataSource?
    var viewModel: TaskListViewModel
    var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCollectionViewLayout()
        configureDataSource()
        configureCollectionView()
        bindViewModelToView()
    }
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(collectionView)
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .supplementary
            config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                guard let self else {
                    return UISwipeActionsConfiguration()
                }
                
                let actionHandler: UIContextualAction.Handler = { action, view, completion in
                    self.viewModel.deleteTask(at: indexPath.row)
                    completion(true)
                }
                
                let action = UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: actionHandler
                )
                
                return UISwipeActionsConfiguration(actions: [action])
            }
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.interGroupSpacing = 10

            return section
        }

        return layout
    }
    
    private func configureCollectionViewLayout() {
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath) as? HeaderView else {
                fatalError("Could not dequeue sectionHeader:")
            }
            
            sectionHeader.titleLabel.text = "Section Header"
            
            return sectionHeader
        }
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Task.ID) -> UICollectionViewCell? {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TaskCell.identifier,
            for: indexPath
        ) as? TaskCell else {
            return UICollectionViewCell()
        }

        guard let task = self.viewModel.taskList.filter({ $0.id == identifier }).first else {
            return UICollectionViewCell()
        }

        let taskCellViewModel = TaskCellViewModel(task: task)
        cell.provide(taskCellViewModel)

        return cell
    }
    
    private func configureCollectionView() {
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func bindViewModelToView() {
        viewModel.currentTaskSubject
            .sink { taskList in
                self.updateDataSource(taskList)
            }
            .store(in: &bindings)
    }
    
    private func updateDataSource(_ taskList: [Task]) {
        let taskIDList = taskList.map { $0.id }
        
        var snapshot = Snapshot()
        snapshot.appendSections([viewModel.taskWorkState])
        snapshot.appendItems(taskIDList, toSection: viewModel.taskWorkState)
        dataSource?.apply(snapshot)
    }
}

extension TaskCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let task = viewModel.task(at: indexPath.row)
        
        let detailViewController = DetailViewController(task: task, mode: .update)
        detailViewController.configureViewModelDelegate(with: viewModel as? DetailViewModelDelegate)
        detailViewController.modalPresentationStyle = .formSheet
        
        self.present(detailViewController, animated: true)
    }
}

extension TaskCollectionViewController: UIGestureRecognizerDelegate {
    
}
