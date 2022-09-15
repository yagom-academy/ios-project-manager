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

    private func bindSectionsHeader() {
        todoCardSectionView.headerView?.countLabel.text = viewModel?.todoList
            .map { "\($0.count)" }

        doingCardSectionView.headerView?.countLabel.text = viewModel?.doingList
            .map { "\($0.count)" }

        doneCardSectionView.headerView?.countLabel.text = viewModel?.doneList
            .map { "\($0.count)" }
    }

    private func initializeViewModel() {
        viewModel?.reloadTodoListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.todoCardDataSource else { return }
            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: card)
            }
        }

        viewModel?.reloadDoingListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.doingCardDataSource else { return }

            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: card)
            }
        }

        viewModel?.reloadDoneListTableViewClosure = { [weak self] (card: [CardModel]) in
            guard let dataSource = self?.doneCardDataSource else { return }

            self?.updateTableView(dataSource,
                                  by: card)
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

            cell.viewModel = self?.viewModel as? CardViewModel
            cell.model = model
            cell.coodinator = self?.coordinator
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

        switch tableView {
        case todoCardSectionView.tableView:
            assignToDetailViewController(viewModel?.todoList?[indexPath.row])
        case doingCardSectionView.tableView:
            assignToDetailViewController(viewModel?.doingList?[indexPath.row])
        default:
            assignToDetailViewController(viewModel?.doneList?[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: Const.delete) { [weak self] (_, _, completionHandler: @escaping (Bool) -> Void) in

            guard let card = self?.search(tableView) else { return }
            self?.viewModel?.delete(card, at: indexPath.row)
            completionHandler(true)
        }

        delete.backgroundColor = .systemRed

        return UISwipeActionsConfiguration(actions: [delete])
    }

    private func search(_ tableView: UITableView) -> CardType? {
        switch tableView {
        case todoCardSectionView.tableView:
            return .todo
        case doingCardSectionView.tableView:
            return .doing
        case doneCardSectionView.tableView:
            return .done
        default:
            return nil
        }
    }

    private func assignToDetailViewController(_ data: CardModel?) {
        if let data {
            self.coordinator?.presentDetailViewController(data)
        }
    }
}
