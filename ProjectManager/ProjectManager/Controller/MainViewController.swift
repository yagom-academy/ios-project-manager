//
//  MainViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
//

import UIKit

final class MainViewController: UIViewController {
    private var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        return stack
    }()
    
    private var collectionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = LayoutConstant.mainStackSpacing
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private var todoCollectionView: UICollectionView?
    private var doingCollectionView: UICollectionView?
    private var doneCollectionView: UICollectionView?
    private var todoDataSource: UICollectionViewDiffableDataSource<Status, Issue>?
    private var doingDataSource: UICollectionViewDiffableDataSource<Status, Issue>?
    private var doneDataSource: UICollectionViewDiffableDataSource<Status, Issue>?
    var todoSnapshot = NSDiffableDataSourceSnapshot<Status, Issue>()
    var doingSnapshot = NSDiffableDataSourceSnapshot<Status, Issue>()
    var doneSnapshot = NSDiffableDataSourceSnapshot<Status, Issue>()
    
    
    private var todoItems: [Issue] = [
        Issue(status: .todo, title: "first", body: "처음할일", dueDate: Date()),
        Issue(status: .todo, title: "second", body: "처음할일?", dueDate: Date()),
        Issue(status: .todo, title: "thrd", body: "처음할일", dueDate: Date()),
        Issue(status: .todo, title: "fth", body: "처음할일", dueDate: Date())
    ]
    
    private var doingItems: [Issue] = [
        Issue(status: .doing, title: "1", body: "처음할일", dueDate: Date()),
        Issue(status: .doing, title: "2", body: "처음할일?", dueDate: Date()),
        Issue(status: .doing, title: "3", body: "처음할일", dueDate: Date()),
    ]
    
    private var doneItems: [Issue] = [
        Issue(status: .done, title: "일", body: "다했당", dueDate: Date()),
        Issue(status: .done, title: "이", body: "처음할일?", dueDate: Date()),
        Issue(status: .done, title: "삼", body: "다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당다했당", dueDate: Date()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureMainStackView()
        configureCollectionStackView()
        configureDataSource()
        
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = Namespace.NavigationTitle
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: Namespace.PlusImage),
                                         style: .plain,
                                         target: self,
                                         action: nil)
        navigationItem.rightBarButtonItem = plusButton
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    
    private func configureCollectionStackView() {
        mainStackView.addArrangedSubview(collectionStackView)
        todoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout(for: .todo))
        doingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout(for: .doing))
        doneCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout(for: .done))
        
        [todoCollectionView, doingCollectionView, doneCollectionView]
            .compactMap { $0 }
            .forEach {
                collectionStackView.addArrangedSubview($0)
            }
    }

    private func configureCollectionViewLayout(for status: Status) -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(44))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        group.interItemSpacing = .fixed(12)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func configureDataSource() {
        guard let todoCollectionView = todoCollectionView,
              let doingCollectionView = doingCollectionView,
              let doneCollectionView = doneCollectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Issue> { (cell, indexPath, item) in
            cell.item = item
        }
        
        todoDataSource = UICollectionViewDiffableDataSource<Status, Issue>(collectionView: todoCollectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            
            return cell
        }
        
        doingDataSource = UICollectionViewDiffableDataSource<Status, Issue>(collectionView: doingCollectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            
            return cell
        }
        
        doneDataSource = UICollectionViewDiffableDataSource<Status, Issue>(collectionView: doneCollectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            
            return cell
        }
        
        Status.allCases.forEach(applySnapshot(for:))
    }

    private func applySnapshot(for status: Status) {
        switch status {
        case .todo:
            todoSnapshot.appendSections([status])
            todoSnapshot.appendItems(todoItems, toSection: status)
            todoDataSource?.apply(todoSnapshot, animatingDifferences: true)
        case .doing:
            doingSnapshot.appendSections([status])
            doingSnapshot.appendItems(doingItems, toSection: status)
            doingDataSource?.apply(doingSnapshot, animatingDifferences: true)
        case .done:
            doneSnapshot.appendSections([status])
            doneSnapshot.appendItems(doneItems, toSection: status)
            doneDataSource?.apply(doneSnapshot, animatingDifferences: true)
        }
    }
}

extension MainViewController {
    enum Namespace {
        static let NavigationTitle = "Project Manager"
        static let PlusImage = "plus"
    }
    
    enum LayoutConstant {
        static let mainStackSpacing = CGFloat(20)
    }
}
