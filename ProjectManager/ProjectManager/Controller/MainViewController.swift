//
//  ProjectManager - ViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class MainViewController: UIViewController {
    enum TodoSection: Hashable {
        case todo
        case doing
        case done
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TodoCollectionViewCell.self, forCellWithReuseIdentifier: TodoCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TodoSection, TodoModel>
    
    private typealias DataSource = UICollectionViewDiffableDataSource<TodoSection, TodoModel>
    
    private lazy var dataSource: DataSource = configureDataSource()
    
    private var todos: [TodoModel] = [TodoModel(title: "todos", body: "본문"),
                                      TodoModel(title: "todos", body: "본문"),
                                      TodoModel(title: "todos", body: "본문")]
    
    private var doings: [TodoModel] = [TodoModel(title: "doings", body: "본문"),
                                       TodoModel(title: "doings", body: "본문"),
                                       TodoModel(title: "doings", body: "본문"),
                                       TodoModel(title: "doings", body: "본문")]
    
    private var dones: [TodoModel] = [TodoModel(title: "dones", body: "본문"),
                                      TodoModel(title: "dones", body: "본문")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureNavagationBar()
        configureCollectionView()
    }
    
    private func configureNavagationBar() {
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(showAddToDoView))
    }
    
    @objc private func showAddToDoView() {}
}

// MARK: - CollectionView
extension MainViewController: UICollectionViewDelegate {
    private func configureCollectionView() {
        collectionView.delegate = self
        applyAutolayout()
        applySnapshot()
    }
    
    private func applyAutolayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.todo, .doing, .done])
        snapshot.appendItems(todos, toSection: .todo)
        snapshot.appendItems(doings, toSection: .doing)
        snapshot.appendItems(dones, toSection: .done)
        self.dataSource.apply(snapshot)
    }
    
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, todo in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoCollectionViewCell.identifier,
                                                          for: indexPath) as? TodoCollectionViewCell
            
            cell?.configureContent(with: todo)
            return cell
        }
        return dataSource
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(44))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])
            
            let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0.1, leading: 0.1, bottom: 0.1, trailing: 0.1)
            return section
        }
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //guard let todo = dataSource.itemIdentifier(for: indexPath) else { return }
    }
}
