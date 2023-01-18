//
//  IssueListViewControllerType.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/17.
//

import UIKit

protocol IssueListViewControllerType: UIViewController {
    var status: Status { get }
    var issueCount: Int { get }
    var issues: [Issue] { get set }
    var delegate: IssueDeliverable { get }
    var stackView: UIStackView { get set }
    var headerView: HeaderView? { get set }
    var collectionView: UICollectionView? { get }
    var dataSource: UICollectionViewDiffableDataSource<Status, Issue>? { get }
}
