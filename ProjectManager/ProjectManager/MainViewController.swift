//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

enum Section {
    case todo
    case doing
    case done
}

struct TodoLabel: Hashable {
    let title: String
    let content: String
    let date: Date
}

class MainViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private lazy var collectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let user = [TodoLabel(title: "Hi!", content: "Andrew!", date: Date()), TodoLabel(title: "Hello~", content: "Brody!", date: Date())]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpCollectionView()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    
        collectionView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.equalTo(view.safeAreaLayoutGuide)
//            $0.trailing.equalTo(view.safeAreaLayoutGuide)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    @objc private func didTapAddButton() {
        modalPresentationStyle = .fullScreen
        present(PopupViewController(), animated: true)
    }
}

// MARK: UICollectionViewDiffableDataSource, CompositionalLayoutConfiguration
extension MainViewController {
    private func setUpCollectionView() {
        // register를 따로 하지 않고 register & configure 작업을 할 수 있다
        let registration = UICollectionView.CellRegistration<TodoListCell, TodoLabel> { cell, IndexPath, todo in
//            var content = cell.defaultContentConfiguration()
//            content.text = todo.titleLable
//            cell.contentConfiguration = content
            
            cell.configure(title: todo.title, content: todo.content, date: todo.date)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView) {
            (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot.appendSections([.todo, .doing, .done])
        snapshot.appendItems(user)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
//    private func createLayout() -> UICollectionViewCompositionalLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                             heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .absolute(44))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                         subitems: [item])
//
//        let section = NSCollectionLayoutSection(group: group)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
}
