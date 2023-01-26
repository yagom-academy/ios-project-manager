//
//  IssueListViewController.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/17.
//

import UIKit

final class IssueListViewController: UIViewController {
    private enum Constant {
        enum Section {
            case main
        }
        
        enum LayoutConstant {
            static let spacing = CGFloat(8)
            static let margin = CGFloat(12)
        }
        
        enum Namespace {
            static let delete = "Delete"
            static let minimumPressDuration = 0.5
            static let alertActionText = "Move to "
        }
    }
    
    private var status: Status
    private var issues: [Issue] = [] {
        didSet {
            issueCountDelegate?.updateCountLabel(with: issues.count)
        }
    }
    
    private var issueListDelegate: IssueListDelegate?
    private var issueCountDelegate: IssueCountDelegate?
    private var dataSource: UICollectionViewDiffableDataSource<Constant.Section, Issue>?
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constant.LayoutConstant.spacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: Constant.LayoutConstant.margin,
            leading: Constant.LayoutConstant.margin,
            bottom: Constant.LayoutConstant.margin,
            trailing: Constant.LayoutConstant.margin
        )
        stack.translatesAutoresizingMaskIntoConstraints = false

        return stack
    }()
    
    private let headerView = HeaderView()
    private lazy var listLayout : UICollectionViewCompositionalLayout = {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.separatorConfiguration.topSeparatorVisibility = .hidden
        listConfiguration.separatorConfiguration.bottomSeparatorVisibility = .hidden
        listConfiguration.trailingSwipeActionsConfigurationProvider = { indexPath in
            let deleteAction = UIContextualAction(
                style: .destructive,
                title: Constant.Namespace.delete
            ) { _, _, _  in
                guard let issue = self.dataSource?.itemIdentifier(for: indexPath) else { return }
                
                self.deleteIssue(issue: issue)
            }
            
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.delegate = self
        
        return collectionView
    }()
    
    init(frame: CGRect = .zero, status: Status, delegate: IssueListDelegate) {
        self.status = status
        self.issueListDelegate = delegate
        self.issueCountDelegate = headerView.countLabel
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
        setLongPressGestureRecognizer()
    }
    
    private func configureUI() {
        configureHeaderView()
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(collectionView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func configureHeaderView() {
        headerView.configureContent(title: String(describing: status), count: issues.count)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomListCell, Issue> {
            (cell, indexPath, item) in
            cell.item = item
        }
        
        dataSource = UICollectionViewDiffableDataSource<Constant.Section, Issue>(collectionView: collectionView) {
            collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Constant.Section, Issue>()
        snapshot.appendSections([.main])
        snapshot.appendItems(issues, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func deleteIssue(issue: Issue) {
        guard var snapshot = dataSource?.snapshot(),
              let index = issues.firstIndex(where: {$0.id == issue.id}) else { return }
        
        snapshot.deleteItems([issue])
        issues.remove(at: index)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setLongPressGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(gestureRecognizer: ))
        )
        gestureRecognizer.minimumPressDuration = Constant.Namespace.minimumPressDuration
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state != .recognized else { return }
        
        let point = gestureRecognizer.location(in: collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        showPopover(indexPath: indexPath)
    }
    
    private func showPopover(indexPath: IndexPath?) {
        guard let indexPath = indexPath,
              let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomListCell,
              let issue = selectedCell.item else { return }
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        createAlertActions(for: issue).forEach(alertController.addAction(_:))
        alertController.popoverPresentationController?.sourceView = collectionView
        alertController.popoverPresentationController?.sourceRect = selectedCell.frame
        alertController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        present(alertController, animated: true)
    }
    
    private func createAlertActions(for issue: Issue) -> [UIAlertAction] {
        var actions: [UIAlertAction] = []
        switch status {
        case .todo:
            actions.append(createAlertAction(issue: issue, to: .doing))
            actions.append(createAlertAction(issue: issue, to: .done))
        case .doing:
            actions.append(createAlertAction(issue: issue, to: .todo))
            actions.append(createAlertAction(issue: issue, to: .done))
        case .done:
            actions.append(createAlertAction(issue: issue, to: .todo))
            actions.append(createAlertAction(issue: issue, to: .doing))
        }
        
        return actions
    }
    
    private func createAlertAction(issue: Issue, to status: Status) -> UIAlertAction {
        let action = UIAlertAction(
            title: Constant.Namespace.alertActionText + String(describing: status),
            style: .default
        ) { _ in
            var modifiedIssue = issue
            modifiedIssue.status = status
            self.deleteIssue(issue: issue)
            self.issueListDelegate?.shouldDeliver(issue: modifiedIssue)
        }
        
        return action
    }
}

extension IssueListViewController: IssueDelegate {
    func shouldAdd(issue: Issue) {
        issues.append(issue)
        applySnapshot()
    }
    
    func shouldUpdate(issue: Issue) {
        guard let index = issues.firstIndex(where: {$0.id == issue.id}) else { return }
        
        issues[index] = issue
        applySnapshot()
    }
}

extension IssueListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let issue = dataSource?.itemIdentifier(for: indexPath) else { return }
        
        let issueViewcontroller = IssueViewController(issue: issue, delegate: self)
        let navigationViewController = UINavigationController(rootViewController: issueViewcontroller)
        self.present(navigationViewController, animated: true)
    }
}
