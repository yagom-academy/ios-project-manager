//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerCollectionViewController: UIViewController {
    private var itemStatusList: [ItemStatus] = [.todo, .doing, .done]
    private let cellSpacing = 10
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat(cellSpacing)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray4
        collectionView.isScrollEnabled = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateDelegate()
        setUpView()
        configureAutoLayout()
        configureNavigationBar()
        configureToolBar()
    }
    
    private func delegateDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setUpView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
    }
    
    private func configureAutoLayout() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Project Manager"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func touchUpAddButton() {
        let listItemDetailViewController = ListItemDetailViewController(statusType: .todo, detailViewType: .create)
        let navigationController = UINavigationController(rootViewController: listItemDetailViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    private func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
    }
}

// MARK: - CollectionView Delegate FlowLayout
extension ProjectManagerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInterval: CGFloat = CGFloat(cellSpacing * (itemStatusList.count - 1))
        let width: CGFloat = CGFloat((collectionView.frame.width - totalInterval) / CGFloat(itemStatusList.count))
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

// MARK: - CollectionView DataSource
extension ProjectManagerCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemStatusList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
        let itemStatus = itemStatusList[indexPath.row]
        let tableView = ListTableView(statusType: itemStatus)
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.listTableViewDelegate = self
        tableView.dragInteractionEnabled = true
        cell.contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        return cell
    }
}

extension ProjectManagerCollectionViewController: ListTableViewDelegate {
    func presentEditView(listItemDetailViewController: ListItemDetailViewController) {
        let navigationController = UINavigationController(rootViewController: listItemDetailViewController)
        present(navigationController, animated: true, completion: nil)
    }
}
