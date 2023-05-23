//
//  ProjectManager - MainListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainListViewController: UIViewController {
    static let headerElementKind = "headrElementKind"
    
    private typealias DataSource = UICollectionViewDiffableDataSource<State, ToDoModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<State, ToDoModel>
    lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    private var dataSource: DataSource?
    private let listViewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        configureCollectionView()
        configureNavigation()
        configureDataSource()
        configureSnapShot()
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int,
                                                                             layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in 
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(30))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .estimated(30))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top:
//                    .fixed(60), trailing: nil, bottom: nil)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
//            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .estimated(60)),
                elementKind: MainListViewController.headerElementKind,
                alignment: .top)
//            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(50)), elementKind: catgoryHeaderId, alignment: .topLeading)]
            section.boundarySupplementaryItems = [sectionHeader]
            
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
        
//        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
//        <CollectionViewHeaderReusableView>(elementKind: MainListViewController.headerElementKind) {
//            (supplementaryView, string, indexPath) in
//            let section = State.allCases[indexPath.section]
//            let count = self.listViewModel.todoList.filter({ $0.state == section }).count
//            
//            supplementaryView.configureContent(title: section.title, count: count)
//        }
//        
//        dataSource?.supplementaryViewProvider = { (view, kind, index) in
//            return self.collectionView.dequeueConfiguredReusableSupplementary(
//                using: supplementaryRegistration, for: index)
//        }
    }
    
    private func configureSnapShot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.Todo])
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Todo }))
        snapshot.appendSections([.Doing])
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Doing }))
        snapshot.appendSections([.Done])
        snapshot.appendItems(listViewModel.todoList.filter({ $0.state == .Done }))
        
        dataSource?.apply(snapshot)
    }
    
    private func configureSubviews() {
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemGray6
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
    }
    
    private func configureNavigation() {
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
