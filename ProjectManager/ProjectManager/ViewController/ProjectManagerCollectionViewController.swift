//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerCollectionViewController: UIViewController {
    private var itemStatusList: [ItemStatus] = [.todo, .doing, .done]
    private let cellSpacing = 10
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = CGFloat(cellSpacing)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray4
        collectionView.isScrollEnabled = false
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
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
        let listItemDetailViewController = ListItemDetailViewController()
        let navigationController = UINavigationController(rootViewController: listItemDetailViewController)
        listItemDetailViewController.configureNavigationBar(itemStatus: .todo, type: .create)
        present(navigationController, animated: true, completion: nil)
    }
    
    private func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        var barButtonItems = [UIBarButtonItem]()
        let flexibleSpaceBarButtonItem: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let undoButton: UIBarButtonItem = .init(barButtonSystemItem: .undo, target: self, action: #selector(touchUpUndoButton))
        let redoButton: UIBarButtonItem = .init(barButtonSystemItem: .redo, target: self, action: #selector(touchUpRedoButton))
        
        barButtonItems.append(flexibleSpaceBarButtonItem)
        barButtonItems.append(undoButton)
        barButtonItems.append(redoButton)
        toolbarItems = barButtonItems
    }
    
    @objc private func touchUpUndoButton() {
        
    }
    
    @objc private func touchUpRedoButton() {
        
    }
}

// MARK: - CollectionView Delegate FlowLayout
extension ProjectManagerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalInterval: CGFloat = CGFloat(cellSpacing * itemStatusList.count - 1)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureTableHeaderView(itemStatus: itemStatusList[indexPath.row])
        return cell
    }
}
