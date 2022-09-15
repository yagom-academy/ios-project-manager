//
//  ProjectManager - CardListViewController.swift
//  Created by Derrick kim.
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class CardListViewController: UIViewController, Coordinating {
    private enum Const {
        static let title = "Project Manager"
        static let plus = "plus"
        static let delete = "삭제"
        static let stackViewSpacing = 10.0
    }
    
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
        $0.spacing = Const.stackViewSpacing
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
        setupDefault()
    }
    
    private func setupDefault() {
        addSubViews()
        configureLayout()
        configureNavigationBarItem()
        applyDelegatePermission()
        bindDataSource()
        initializeViewModel()
    }
    
    private func addSubViews() {
        self.title = Const.title
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(todoCardSectionView)
        rootStackView.addArrangedSubview(doingCardSectionView)
        rootStackView.addArrangedSubview(doneCardSectionView)
    }

    private func applyDelegatePermission() {
        todoCardSectionView.tableView.delegate = self
        doingCardSectionView.tableView.delegate = self
        doneCardSectionView.tableView.delegate = self
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Const.plus),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(plusButtonTapped(_:)))
    }

    private func bindDataSource() {
        let dataDictionary = [todoCardDataSource: viewModel?.todoList,
                             doingCardDataSource: viewModel?.doingList,
                              doneCardDataSource: viewModel?.doneList]

        dataDictionary
            .forEach { dataSource, cardModel in
                guard let dataSource = dataSource,
                      let cardModel = cardModel else { return }
                updateTableView(dataSource, by: cardModel)
            }
    }
    
    @objc private func plusButtonTapped(_ sender: UIBarButtonItem) {
        coordinator?.presentEnrollmentViewController()
    }
}

// MARK: TableView DataSource

private extension CardListViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, CardModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CardModel>
    
    enum Section {
        case main
    }
    
    func updateTableView(_ dataSource: DataSource,
                         by data: [CardModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot,
                         animatingDifferences: false,
                         completion: nil)
    }
    
    func configureDataSource(with tableView: UITableView) -> DataSource? {
        let dataSource = DataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, model -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardListTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? CardListTableViewCell,
                  let data = self?.viewModel?.convert(from: model) else {
                return UITableViewCell()
            }
            
            cell.model = model
            cell.bindUI(data)

            return cell
        })
        
        return dataSource
    }
}

// MARK: TableView Action

extension CardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.coordinator?.presentDetailViewController(TodoListModel.sample[indexPath.row])
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: Const.delete) { (_, _, completionHandler: @escaping (Bool) -> Void) in
            completionHandler(true)
        }
        
        delete.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
