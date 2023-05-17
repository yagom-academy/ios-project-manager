//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import UIKit

final class TaskListViewController: UIViewController {
    private let collectionView = UICollectionView()
    private var dataSource: UICollectionViewDiffableDataSource<Task.State, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func configureCollectionView() {
//        dataSource = UICollectionViewDiffableDataSource<Task.State, Task>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
//        }
//    }
}
