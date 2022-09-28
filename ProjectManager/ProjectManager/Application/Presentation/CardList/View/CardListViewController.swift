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
        static let history = "History"
        static let stackViewSpacing = 10.0
        static let tableViewFirstTag = 1
        static let tableViewSecondTag = 2
        static let tableViewThirdTag = 3
    }

    var coordinator: CoordinatorProtocol?
    private var viewModel: CardViewModelProtocol
    
    private lazy var todoCardDataSource = self.configureDataSource(with: todoCardSectionView.tableView)
    private lazy var doingCardDataSource = self.configureDataSource(with: doingCardSectionView.tableView)
    private lazy var doneCardDataSource = self.configureDataSource(with: doneCardSectionView.tableView)
    
    private lazy var todoCardSectionView = CardSectionView(coordinator: coordinator ?? MainCoordinator(),
                                                           viewModel: viewModel,
                                                           type: .todo)
    private lazy var doingCardSectionView = CardSectionView(coordinator: coordinator ?? MainCoordinator(),
                                                            viewModel: viewModel,
                                                            type: .doing)
    private lazy var doneCardSectionView = CardSectionView(coordinator: coordinator ?? MainCoordinator(),
                                                           viewModel: viewModel,
                                                           type: .done)
    
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
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
    }
    
    private func setupDefault() {
        addSubViews()
        configureLayout()
        configureNavigationBarItem()
        applyTableViewTag()
        bindDataSource()
        bindSectionsHeader()
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

    private func applyTableViewTag() {
        todoCardSectionView.tableView.tag = Const.tableViewFirstTag
        doingCardSectionView.tableView.tag = Const.tableViewSecondTag
        doneCardSectionView.tableView.tag = Const.tableViewThirdTag
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Const.history,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(didTapHistoryButton(_:)))

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Const.plus),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(didTapPlusButton(_:)))
    }

    private func bindDataSource() {
        let dataDictionary = [todoCardDataSource: viewModel.todoList,
                             doingCardDataSource: viewModel.doingList,
                              doneCardDataSource: viewModel.doneList]

        dataDictionary
            .forEach { dataSource, cardModel in
                guard let dataSource = dataSource,
                      let cardModel = cardModel else { return }
                updateTableView(dataSource,
                                by: cardModel)
            }
    }

    private func bindSectionsHeader() {
        todoCardSectionView.headerView.countLabel.text = viewModel.todoList
            .map { "\($0.count)" }

        doingCardSectionView.headerView.countLabel.text = viewModel.doingList
            .map { "\($0.count)" }

        doneCardSectionView.headerView.countLabel.text = viewModel.doneList
            .map { "\($0.count)" }
    }

    private func initializeViewModel() {
        viewModel.reloadTodoListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.todoCardDataSource else { return }
            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: card)

                self?.todoCardSectionView.headerView.countLabel.text = "\(card.count)"
            }
        }

        viewModel.reloadDoingListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.doingCardDataSource else { return }

            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: card)

                self?.doingCardSectionView.headerView.countLabel.text = "\(card.count)"
            }
        }

        viewModel.reloadDoneListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.doneCardDataSource else { return }
            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: card)

                self?.doneCardSectionView.headerView.countLabel.text = "\(card.count)"
            }
        }

        viewModel.presentNetworkingAlert = { [weak self] in
            guard let message = self?.viewModel.alertMessage else { return }
            self?.presentAlertConfirmAction(title: "알림", message: message)
        }
    }
    
    @objc private func didTapPlusButton(_ sender: UIBarButtonItem) {
        coordinator?.presentEnrollmentViewController()
    }

    @objc private func didTapHistoryButton(_ sender: UIBarButtonItem) {
        coordinator?.presentHistoryViewActionSheet(sender)
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
                  let coordinator = self?.coordinator else {
                return UITableViewCell()
            }
            let viewModel = CardListItemViewModel(coordinator: coordinator,
                                                  model: model)
            cell.viewModel = viewModel
            cell.bindUI()
            return cell
        })
        
        return dataSource
    }
}
