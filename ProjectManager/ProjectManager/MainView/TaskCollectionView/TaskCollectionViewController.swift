//
//  TaskCollectionViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/25.
//

import UIKit
import Combine

final class TaskCollectionViewController<Section: Hashable>: UIViewController, UICollectionViewDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Task.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Task.ID>
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    
    var dataSource: DataSource?
    var viewModel: any TaskListViewModel
    var bindings = Set<AnyCancellable>()
    private let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter
    }()
    
    private var currentLongPressedCell: TaskCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCollectionViewLayout()
        configureDataSource()
        configureCollectionView()
        bindViewModelToView()
        setupLongTapGestureRecognizer()
    }
    
    init(viewModel: any TaskListViewModel) {
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
            
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(70)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.boundarySupplementaryItems = [sectionHeader]
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)

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
                for: indexPath
            ) as? HeaderView else {
                fatalError("Could not dequeue sectionHeader:")
            }
            
            let viewModel = HeaderViewModel(
                titleText: self.viewModel.taskWorkState.text,
                badgeCount: self.viewModel.taskList.count
            )
            sectionHeader.provide(viewModel: viewModel)
            
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

        let taskCellViewModel = TaskCellViewModel(task: task, dateFormatter: dateFormatter)
        cell.provide(viewModel: taskCellViewModel)

        return cell
    }
    
    private func configureCollectionView() {
        collectionView.register(TaskCell.self, forCellWithReuseIdentifier: TaskCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func bindViewModelToView() {
        viewModel
            .currentTaskSubject
            .sink { taskList, isUpdating in
                isUpdating ? self.reloadDataSourceItems() : self.applyLatestSnapshot(taskList)
                
                self.viewModel.setState(isUpdating: false)
            }
            .store(in: &bindings)
    }
    
    private func applyLatestSnapshot(_ taskList: [Task]) {
        guard let section = viewModel.sectionInfo as? Section else {
            return
        }
        
        let taskIDList = taskList.map { $0.id }
        
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(taskIDList, toSection: section)
        dataSource?.apply(snapshot)
    }
    
    private func reloadDataSourceItems() {
        guard var snapshot = dataSource?.snapshot() else { return }
        let taskListID = viewModel.taskList.map { $0.id }
        
        snapshot.reloadItems(taskListID)
        dataSource?.apply(snapshot)
    }
    
    private func setupLongTapGestureRecognizer() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc
    private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: collectionView)
        
        if gestureRecognizer.state == .began {
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath) as? TaskCell else {
                return
            }
            
            self.currentLongPressedCell = cell
        }
        
        if gestureRecognizer.state == .ended {
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = self.currentLongPressedCell else {
                return
            }
            
            if cell == collectionView.cellForItem(at: indexPath) {
                guard let task = viewModel.task(at: indexPath.row),
                      let mainViewController = self.parent as? MainViewController
                else {
                    return
                }
                
                let changeWorkStateViewModel = ChangeWorkStateViewModel(from: task)
                changeWorkStateViewModel.delegate = mainViewController.mainViewModel
                
                let changeWorkStateViewController = ChangeWorkStateViewController(
                    viewModel: changeWorkStateViewModel
                )
                changeWorkStateViewController.modalPresentationStyle = .popover
                changeWorkStateViewController.popoverPresentationController?.sourceView = cell
                changeWorkStateViewController.preferredContentSize = CGSize(width: 300, height: 120)
                changeWorkStateViewController.popoverPresentationController?.sourceRect = CGRect(
                    origin: CGPoint(x: cell.bounds.midX, y: cell.bounds.midY),
                    size: .zero
                )
                changeWorkStateViewController.popoverPresentationController?.permittedArrowDirections = .down
                
                self.present(changeWorkStateViewController, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let task = viewModel.task(at: indexPath.row)
        
        let detailViewModel = DetailViewModel(from: task, mode: .update)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        detailViewController.configureViewModelDelegate(with: viewModel as? DetailViewModelDelegate)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        self.present(navigationController, animated: true)
    }
}

