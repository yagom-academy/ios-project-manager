//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit

enum Section {
    case main
}

struct TodoLabel: Hashable {
    let title: String
    let content: String
    let date: Date
}

class MainViewController: UIViewController {
    private var dataSource1: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var dataSource2: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var dataSource3: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private let collectionView1 = CustomCollectionView()
    private let collectionView2 = CustomCollectionView()
    private let collectionView3 = CustomCollectionView()
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [collectionView1, collectionView2, collectionView3])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private let todoList = [TodoLabel(title: "책상정리", content: "집중이 안될때 역시나 책상정리", date: Date()), TodoLabel(title: "일기정리", content: "난 가끔 일기를 쓴다", date: Date()), TodoLabel(title: "빨래하기", content: "그만 쌓아두고 싶다....", date: Date())]
    private let doingList = [TodoLabel(title: "Hi!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!", content: "Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!Andrew!", date: Date()), TodoLabel(title: "Hello~", content: "Brody!", date: Date())]
    private let doneList = [TodoLabel(title: "방정리", content: "눈감고 그댈 그려요 맘속 그댈 찾았죠", date: Date())]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpDataSource()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(-50)
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
    private func configureCellRegistration() -> UICollectionView.CellRegistration<TodoListCell, TodoLabel> {
        return UICollectionView.CellRegistration<TodoListCell, TodoLabel> { cell, IndexPath, todo in
            cell.configure(title: todo.title, content: todo.content, date: todo.date)
        }
    }

    private func configureHeaderRegistration(headerText: String, listCount: Int) -> UICollectionView.SupplementaryRegistration<Header> {
        return UICollectionView.SupplementaryRegistration<Header>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, _, _) in
            headerView.headerLabel.text = headerText
            headerView.cellCountLabel.text = String(listCount)
        }
    }
    
    private func configureDataSource(collectionView: UICollectionView, registration: UICollectionView.CellRegistration<TodoListCell, TodoLabel>, headerRegistration: UICollectionView.SupplementaryRegistration<Header>) -> UICollectionViewDiffableDataSource<Section, TodoLabel> {
        let dataSource = UICollectionViewDiffableDataSource<Section, TodoLabel>(collectionView: collectionView) { (collectionView, indexPath, todo) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: todo)
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        
        return dataSource
    }

    private func setUpDataSource() {
        let registration = configureCellRegistration()
        let headerRegistration1 = configureHeaderRegistration(headerText: "TODO", listCount: todoList.count)
        let headerRegistration2 = configureHeaderRegistration(headerText: "DOING", listCount: doingList.count)
        let headerRegistration3 = configureHeaderRegistration(headerText: "DONE", listCount: doneList.count)

        dataSource1 = configureDataSource(collectionView: collectionView1, registration: registration, headerRegistration: headerRegistration1)
        dataSource2 = configureDataSource(collectionView: collectionView2, registration: registration, headerRegistration: headerRegistration2)
        dataSource3 = configureDataSource(collectionView: collectionView3, registration: registration, headerRegistration: headerRegistration3)

        var snapshot1 = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot1.appendSections([.main])
        snapshot1.appendItems(todoList, toSection: .main)
        
        var snapshot2 = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot2.appendSections([.main])
        snapshot2.appendItems(doingList, toSection: .main)
        
        var snapshot3 = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        snapshot3.appendSections([.main])
        snapshot3.appendItems(doneList, toSection: .main)
        

        dataSource1?.apply(snapshot1, animatingDifferences: true)
        dataSource2?.apply(snapshot2, animatingDifferences: true)
        dataSource3?.apply(snapshot3, animatingDifferences: true)
    }
}
