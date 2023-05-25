//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit
import Combine

final class TaskListViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<TaskState, MyTask>

    private let state: TaskState
    private let viewModel: TaskListViewModel
    private var dataSource: DataSource?
    private let headerView: TaskListHeaderView
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        
        collectionView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(TaskListCell.self,
                                forCellWithReuseIdentifier: TaskListCell.reuseIdentifier)
        
        return collectionView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        
        return stackView
    }()
    
    init(state: TaskState) {
        self.state = state
        viewModel = TaskListViewModel(state: state)
        headerView = TaskListHeaderView(state: state)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        addSubViews()
        setupStackViewConstraints()
        setupCollectionView()
        bind()
        setupLongGestureRecognizerOnCollection()
    }
    
    private func addSubViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(collectionView)
    }

    private func setupStackViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safe.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { [weak self] sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.showsSeparators = false
            config.trailingSwipeActionsConfigurationProvider = self?.makeSwipeAction
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.interGroupSpacing = 10
            
            return section
        }
        
        return layout
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, task in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.reuseIdentifier,
                for: indexPath
            ) as? TaskListCell else { return UICollectionViewCell() }
            
            cell.bind(task)
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.$taskList
            .sink { [weak self] taskList in
                guard let self else { return }
                
                var snapshot = NSDiffableDataSourceSnapshot<TaskState, MyTask>()
                
                snapshot.appendSections([self.state])
                snapshot.appendItems(taskList)
                
                self.dataSource?.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &subscriptions)
    }
    
    private func makeSwipeAction(_ indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteActionTitle = "Delete"
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: deleteActionTitle) {
            [weak self] _, _, handler in
            self?.viewModel.delete(indexPath: indexPath)
            handler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension TaskListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let task = viewModel.taskList[indexPath.row]
        let taskFormViewController = TaskFormViewController(task: task)
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        
        present(navigationController, animated: true)
    }
}

extension TaskListViewController: UIGestureRecognizerDelegate {
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer:))
        )
        
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: collectionView)
        
        guard gestureRecognizer.state == .began else { return }
        
        guard let indexPath = collectionView.indexPathForItem(at: location),
              let cell = collectionView.cellForItem(at: indexPath) as? TaskListCell else { return }
        
        let alertController = makeMovingSheet(cell: cell, indexPath: indexPath)
        
        present(alertController, animated: true)
    }
    
    private func makeMovingSheet(cell: TaskListCell, indexPath: IndexPath) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let states = state.others
        
        let firstAction = UIAlertAction(title: viewModel.firstPopoverActionTitle, style: .default) { [weak self] _ in
            self?.viewModel.changeState(indexPath: indexPath, state: states.first)
        }
        
        let secondAction = UIAlertAction(title: viewModel.secondPopoverActionTitle, style: .default) { [weak self] _ in
            self?.viewModel.changeState(indexPath: indexPath, state: states.second)
        }
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = cell
            popoverController.sourceRect = CGRect(x: cell.bounds.midX, y: cell.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = [.up, .down]
        }
        
        return alertController
    }
}
