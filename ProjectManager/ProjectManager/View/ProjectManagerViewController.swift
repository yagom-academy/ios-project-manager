//
//  ProjectManager - ViewController.swift
//  Created by Finnn.
//  Copyright © Finnn. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cellIdentifier = "tableViewCell"
    private var collectionView: UICollectionView?
    
    private var viewModel = ProjectManagerViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewBackgroundColor()
        configureCollectionView()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addCollectionViewBottomLine(borderWidth: 2, color: .systemGray5)
    }
}

// MARK: - Configure Methods

extension ProjectManagerViewController {
    private func configureNavigationBar() {
        title = "Project Manager"
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
    }
    
    private func configureViewBackgroundColor() {
        self.view.backgroundColor = .systemBackground.withAlphaComponent(0.98)
    }
    
    private func configureCollectionView() {
        let collectionViewLayout = createLayout()
        let initialCollectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: collectionViewLayout
        )
        
        initialCollectionView.backgroundColor = .systemGray5
        initialCollectionView.register(
            ProjectManagerCollectionViewCell.self,
            forCellWithReuseIdentifier: cellIdentifier
        )
        initialCollectionView.isScrollEnabled = false
        initialCollectionView.dataSource = self
        
        self.collectionView = initialCollectionView
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureHierarchy() {
        guard let collectionView = self.collectionView else { return }
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        guard let collectionView = self.collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - Objective-C Methods

extension ProjectManagerViewController {
    @objc private func rightBarButtonTapped(sender: UIView) {
        let todoDetailNavigationController = UINavigationController(rootViewController: TodoDetailViewController())
        present(todoDetailNavigationController, animated: true)
    }
}

// MARK: - Other Methods

extension ProjectManagerViewController {
    private func addCollectionViewBottomLine(borderWidth: CGFloat, color: UIColor) {
        guard let collectionView = collectionView else { return }

        let downBorder = CALayer()
        downBorder.frame = CGRect(
            x: 0, y: collectionView.frame.height - borderWidth,
            width: collectionView.frame.width, height: borderWidth
        )
        downBorder.backgroundColor = color.cgColor

        collectionView.layer.addSublayer(downBorder)
    }
}

// MARK: - UICollectionViewDataSource

extension ProjectManagerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TodoStatus.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionView = self.collectionView,
              let status = TodoStatus(rawValue: indexPath.row),
              let categoriedTodoList = self.viewModel.categorizedTodoList[status],
              let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
              ) as? ProjectManagerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.set(status: status, categorizedTodoList: categoriedTodoList)
        
        return cell
    }
}
