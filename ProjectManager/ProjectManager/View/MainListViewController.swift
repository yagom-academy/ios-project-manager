//
//  ProjectManager - MainListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainListViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<State, ToDoModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<State, ToDoModel>
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    private var dataSource: DataSource?
    private let listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        configureNavigation()
        configureDataSource()
        configureSnapShot()
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int,
                                                                             layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(30))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .estimated(30))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            
            return section
        }, configuration: configuration)
        
        return layout
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListViewCell, ToDoModel> { cell, indexPath, item in
            cell.configureContent(with: item)
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: item)
        }
    }
    
    private func configureSnapShot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.Todo])
        snapshot.appendSections([.Doing])
        snapshot.appendSections([.Done])
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Todo }))
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Doing }))
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Done }))
        
        dataSource?.apply(snapshot)
    }
    
    private func configureSubviews() {
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigation() {
        view.backgroundColor = .white
        title = NameSpace.projectName
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    @objc
    private func addProject() {
        let addProjectViewController = AddProjectViewController()
        addProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: addProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
    }
}

private enum NameSpace {
    static let projectName = "Project Manager"
}
