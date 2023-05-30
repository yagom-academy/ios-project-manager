//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import Combine
import SnapKit

enum Section {
    case main
}

class MainViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    
    private var todoDataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var doingDataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    private var doneDataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?
    
    private let todoCollectionView = CustomCollectionView()
    private let doingCollectionView = CustomCollectionView()
    private let doneCollectionView = CustomCollectionView()
    private lazy var mainStackView = {
        let stackView = UIStackView(arrangedSubviews: [todoCollectionView, doingCollectionView, doneCollectionView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
        setUpDataSource()
        
        observeListChanges()
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
    
    @objc private func didTapAddButton(sender: UIBarButtonItem) {
        modalPresentationStyle = .fullScreen
        let vc = PopupViewController()
        let nvc = UINavigationController(rootViewController: vc)
        
        vc.updateSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedList in
                self?.updateListSnapshot(updatedList, section: .main, dataSource: self?.todoDataSource)
            }
            .store(in: &cancellables)
        
        present(nvc, animated: true, completion:nil)
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
    
    private func observeListChanges(for listPublisher: AnyPublisher<[TodoLabel], Never>, snapshotUpdater: @escaping ([TodoLabel]) -> Void) {
        listPublisher
            .sink { list in
                snapshotUpdater(list)
            }
            .store(in: &cancellables)
    }
    
    private func setUpDataSource() {
        let registration = configureCellRegistration()
        let todoHeader = configureHeaderRegistration(headerText: "TODO", listCount: TodoListDataManager.shared.listCount().todo)
        let doingHeader = configureHeaderRegistration(headerText: "DOING", listCount: TodoListDataManager.shared.listCount().doing)
        let doneHeader = configureHeaderRegistration(headerText: "DONE", listCount: TodoListDataManager.shared.listCount().done)
        
        todoDataSource = configureDataSource(collectionView: todoCollectionView, registration: registration, headerRegistration: todoHeader)
        doingDataSource = configureDataSource(collectionView: doingCollectionView, registration: registration, headerRegistration: doingHeader)
        doneDataSource = configureDataSource(collectionView: doneCollectionView, registration: registration, headerRegistration: doneHeader)
    }
    
    private func updateListSnapshot(_ list: [TodoLabel], section: Section, dataSource: UICollectionViewDiffableDataSource<Section, TodoLabel>?) {
        let sortedList = list.sorted { $0.date < $1.date }
        var snapshot = NSDiffableDataSourceSnapshot<Section, TodoLabel>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(sortedList, toSection: .main)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func observeListChanges() {
        observeListChanges(for: TodoListDataManager.shared.todoListPublisher) { [weak self] todoList in
            self?.updateListSnapshot(todoList, section: .main, dataSource: self?.todoDataSource)
        }

        observeListChanges(for: TodoListDataManager.shared.doingListPublisher) { [weak self] doingList in
            self?.updateListSnapshot(doingList, section: .main, dataSource: self?.doingDataSource)
        }

        observeListChanges(for: TodoListDataManager.shared.doneListPublisher) { [weak self] doneList in
            self?.updateListSnapshot(doneList, section: .main, dataSource: self?.doneDataSource)
        }
    }
}
