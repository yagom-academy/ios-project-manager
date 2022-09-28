//
//  CardHistoryViewController.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/26.
//

import UIKit
import Then

final class CardHistoryViewController: UIViewController, Coordinating {
    private enum Const {
        static let baseConstraint = 10.0
    }

    private let historyTableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorInset.left = 0
        $0.register(CardHistoryTableViewCell.self,
                    forCellReuseIdentifier: CardHistoryTableViewCell.reuseIdentifier)
    }

    var coordinator: CoordinatorProtocol?

    private lazy var dataSource = self.configureDataSource(with: historyTableView)
    private var viewModel: CardHistoryViewModel

    init(viewModel: CardHistoryViewModel,
         coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        setupDefault()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    func setupDefault() {
        addSubViews()
        configureLayout()
        initializeViewModel()
        bindDataSource()
    }

    func addSubViews() {
        self.view.addSubview(historyTableView)
    }

    private func bindDataSource() {
        guard let dataSource = dataSource else { return }
        let cardHistoryList = viewModel.cardHistoryModelList

        self.updateTableView(dataSource,
                             by: cardHistoryList)
    }

    private func initializeViewModel() {
        viewModel.reloadHistoryTableViewClosure = { [weak self] cardHistoryList in
            guard let dataSource = self?.dataSource else { return }

            DispatchQueue.main.async {
                self?.updateTableView(dataSource,
                                      by: cardHistoryList)
            }
        }
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                  constant: Const.baseConstraint),
            historyTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                     constant: -Const.baseConstraint),
            historyTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                      constant: Const.baseConstraint),
            historyTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                       constant: -Const.baseConstraint)
        ])
    }
}

extension CardHistoryViewController {
    typealias DataSource = UITableViewDiffableDataSource<Section, CardHistoryModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CardHistoryModel>

    enum Section {
        case main
    }

    func updateTableView(_ dataSource: DataSource,
                         by data: [CardHistoryModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)

        dataSource.apply(snapshot,
                         animatingDifferences: false,
                         completion: nil)
    }

    func configureDataSource(with tableView: UITableView) -> DataSource? {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, model -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardHistoryTableViewCell.reuseIdentifier,
                                                           for: indexPath) as? CardHistoryTableViewCell else {
                return UITableViewCell()
            }

            let viewCellModel = CardHistoryItemViewModel(cardHistoryModel: model)
            cell.bindUI(viewModel: viewCellModel)
            return cell
        })

        return dataSource
    }
}
