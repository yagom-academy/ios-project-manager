//
//  ProjectTodoHistoryViewController.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/27.
//

import UIKit

final class ProjectTodoHistoryViewController: UICollectionViewController {

    // MARK: - Properties

    private let projectTodoHistoryViewModel: ProjectTodoHistoryViewModel
    private var dataSource: DataSource?

    // MARK: - Configure

    init(projectTodoHistoryViewModel: ProjectTodoHistoryViewModel) {
        self.projectTodoHistoryViewModel = projectTodoHistoryViewModel

        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        super.init(collectionViewLayout: UICollectionViewCompositionalLayout.list(using: configuration))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureDataSource()
        updateSnapshot()
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration(handler: makeCellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        })
    }
}

// MARK: - DataSource

extension ProjectTodoHistoryViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, UUID>

    private func makeCellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: UUID) {
        guard let projectTodoHistory = projectTodoHistoryViewModel.projectTodoHistory(for: id) else { return }
        var configuration = UIListContentConfiguration.cell()
        configuration.text = projectTodoHistoryViewModel.localizedString(projectTodoHistory)
        configuration.textProperties.font = UIFont.preferredFont(forTextStyle: .title3)
        configuration.secondaryText = projectTodoHistory.date.localizedDateTimeString()
        configuration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .body)
        cell.contentConfiguration = configuration
    }

    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(projectTodoHistoryViewModel.peekLastIDs(Constants.historyItemMaxCount))
        dataSource?.apply(snapshot)
    }
}
