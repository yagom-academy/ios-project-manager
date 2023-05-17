//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

final class TaskListViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Task.State, Task>
    
    private var collectionView: UICollectionView! = nil
    private var dataSource: DataSource?
    private let viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureCollectionView()
        setUpCollectionViewConstraints()
    }
    
    private func setUpCollectionViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(TaskListCell.self,
                                forCellWithReuseIdentifier: TaskListCell.identifier)
//        collectionView.collectionViewLayout = createCollectionViewLayout()
        
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, task in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TaskListCell.identifier,
                for: indexPath
            ) as? TaskListCell else { return UICollectionViewCell() }
            
            cell.configure(task)
            
            return cell
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            let sectionLayoutKind = Task.State.allCases[sectionIndex]
            
            switch sectionLayoutKind {
            case .todo:
                return self.createListLayout()
            case .doing:
                return self.createListLayout()
            case .done:
                return self.createListLayout()
            }
        }
                
        return layout
    }
    
    private func createListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                               heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Task.State, Task> {
        var snapshot = NSDiffableDataSourceSnapshot<Task.State, Task>()
        snapshot.appendSections([Task.State.todo])
        snapshot.appendItems([Task(state: .todo, title: "투두테스트", body: "투두투두", deadline: Date())])
        
        snapshot.appendSections([Task.State.doing])
        snapshot.appendItems([Task(state: .doing, title: "두잉테스트", body: "투두투두", deadline: Date())])
        
        snapshot.appendSections([Task.State.done])
        snapshot.appendItems([Task(state: .done, title: "돈테스트", body: "투두투두", deadline: Date())])
        
        return snapshot
    }
}
