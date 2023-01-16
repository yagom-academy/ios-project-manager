//
//  IssueListViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/17.
//

import UIKit

final class IssueListViewController: UIViewController, IssueListViewControllerType {
    var status: Status
    var issueCount: Int = .zero
    var issues: [Issue] = []
    var issueManager: IssueManager?
    var dataSource: UICollectionViewDiffableDataSource<Status, Issue>?
    var snapshot = NSDiffableDataSourceSnapshot<Status, Issue>()
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = LayoutConstant.spacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: LayoutConstant.margin,
                                                                 leading: LayoutConstant.margin,
                                                                 bottom: LayoutConstant.margin,
                                                                 trailing: LayoutConstant.margin)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    var headerView: HeaderView?
    var collectionView: UICollectionView?
    
    init(status: Status) {
        self.status = status
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func configureUI() {
        configureStackView()
        configureHeaderView()
    }
    
    private func configureStackView() {
        
    }
    
    private func configureHeaderView() {
        headerView = HeaderView(title: status.description, count: issueCount)
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.separatorConfiguration.topSeparatorVisibility = .hidden
        listConfiguration.separatorConfiguration.bottomSeparatorVisibility = .hidden
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else { return }
        
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Issue> {
            (cell, indexPath, item) in
            cell.item = item
        }
        
        dataSource = UICollectionViewDiffableDataSource<Status, Issue>(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: itemIdentifier)
            
            return cell
        }
    }
    
    private func applySnapshot() {
        snapshot.appendSections([status])
        snapshot.appendItems(issues, toSection: status)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    enum LayoutConstant {
        static let spacing = CGFloat(8)
        static let margin = CGFloat(12)
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // present IssueViewController
    }
}
