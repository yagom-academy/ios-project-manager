//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit
import Combine

final class TaskListViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<State, Task>

    private let state: State
    private let viewModel: TaskListViewModel
    private var dataSource: DataSource?
    private let headerView: TaskListHeaderView
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        
        collectionView.backgroundColor = .systemGray6
        collectionView.register(TaskListCell.self,
                                forCellWithReuseIdentifier: TaskListCell.identifier)
        
        return collectionView
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = .systemGray3
        stackView.spacing = 2
        
        return stackView
    }()
    
    init(state: State) {
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(40))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(40))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    private func setupCollectionView() {
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, task in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.identifier,
                for: indexPath
            ) as? TaskListCell else { return UICollectionViewCell() }
            
            cell.configure(task)
            
            return cell
        }
    }
    
    private func bind() {
        viewModel.filteredTaskPublisher()
            .sink { taskList in
                var snapshot = NSDiffableDataSourceSnapshot<State, Task>()
                
                snapshot.appendSections([self.state])
                snapshot.appendItems(taskList)
                
                self.dataSource?.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &subscriptions)
    }
}
