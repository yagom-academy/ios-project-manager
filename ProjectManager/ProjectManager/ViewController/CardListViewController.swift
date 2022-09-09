//
//  ProjectManager - CardListViewController.swift
//  Created by Derrick kim.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class CardListViewController: UIViewController, Coordinating {
    var coordinator: CoordinatorProtocol?
    private var viewModel: CardViewModelProtocol?
    
    private lazy var todoCardDataSource = self.configureDataSource(with: todoCardSectionView.tableView)
    private lazy var doingCardDataSource = self.configureDataSource(with: doingCardSectionView.tableView)
    private lazy var doneCardDataSource = self.configureDataSource(with: doneCardSectionView.tableView)
    
    private let todoCardSectionView = CardSectionView(type: .todo)
    private let doingCardSectionView = CardSectionView(type: .doing)
    private let doneCardSectionView = CardSectionView(type: .done)
    
    private let rootStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.backgroundColor = .systemGray4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(viewModel: CardViewModelProtocol,
         coordinator: CoordinatorProtocol) {
        
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureLayout()
        configureNavigationBarItem()
        applyTableViewDataSources()
    }
    
    private func addSubViews() {
        self.title = "Project Manager"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(todoCardSectionView)
        rootStackView.addArrangedSubview(doingCardSectionView)
        rootStackView.addArrangedSubview(doneCardSectionView)
    }
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureNavigationBarItem() {
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(plusButtonTapped(_:)))
    }
    
    private func applyTableViewDataSources() {
        let dataSources = [todoCardDataSource, doingCardDataSource, doneCardDataSource]
        
        dataSources
            .forEach { dataSource in
                guard let dataSource = dataSource else { return }
                
                updateTableView(dataSource, by: TodoListModel.sample)
            }
    }
    
    @objc private func plusButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.eventOccurred(with: .plusButtonTapped)
    }
}

private extension CardListViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, TodoListModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TodoListModel>
    
    enum Section {
        case main
    }
    
    func updateTableView(_ dataSource: DataSource, by data: [TodoListModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot,
                         animatingDifferences: false,
                         completion: nil)
    }
    
    func configureDataSource(with tableView: UITableView) -> DataSource? {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListTableViewCell.identifier,
                                                           for: indexPath) as? CardListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.model = model
            return cell
        })
        
        return dataSource
    }
}
