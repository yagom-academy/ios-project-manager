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
    
    init(frame: CGRect = .zero, status: Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        applySnapshot()
    }
    
    private func configureUI() {
        configureStackView()
        configureHeaderView()
        configureCollectionView()
        embedInStack()
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func configureHeaderView() {
        headerView = HeaderView(title: status.description, count: issueCount)
        
        
    }
    
    private func configureCollectionView() {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.separatorConfiguration.topSeparatorVisibility = .hidden
        listConfiguration.separatorConfiguration.bottomSeparatorVisibility = .hidden
        listConfiguration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let deleteAction = UIContextualAction(style: .destructive,
                                                  title: Namespace.delete) { action, view, completion in
                guard let issue = self.dataSource?.itemIdentifier(for: indexPath) else { return }
                self.deleteIssue(issue: issue)
            }
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
    }
    
    private func embedInStack() {
        guard let headerView = headerView,
              let collectionView = collectionView else { return }
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(collectionView)
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
        var snapshot = NSDiffableDataSourceSnapshot<Status, Issue>()
        snapshot.appendSections([status])
        snapshot.appendItems(issues, toSection: status)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteIssue(issue: Issue) {
        guard var snapshot = dataSource?.snapshot(),
              let index = issues.firstIndex(where: {$0.id == issue.id}) else { return }
        snapshot.deleteItems([issue])
        issues.remove(at: index)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    enum LayoutConstant {
        static let spacing = CGFloat(8)
        static let margin = CGFloat(12)
    }
    
    enum Namespace {
        static let delete = "Delete"
    }
}

extension IssueListViewController: IssueManageable {
    func addIssue(issue: Issue?) {
        guard let issue = issue else { return }
        issues.append(issue)
        applySnapshot()
    }
    
    func updateIssue(issue: Issue?) {
        guard let issue = issue,
              let index = issues.firstIndex(where: {$0.id == issue.id}) else { return }
        
        issues.remove(at: index)
        issues.append(issue)
        applySnapshot()
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let issue = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        let issueViewcontroller = IssueViewController(issue: issue,
                                                      delegate: self)
        let navigationViewController = UINavigationController(rootViewController: issueViewcontroller)
        self.present(navigationViewController, animated: true)
    }
}
