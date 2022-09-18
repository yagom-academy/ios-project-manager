//
//  ProjectManager - ViewController.swift
//  Created by Finnn.
//  Copyright © Finnn. All rights reserved.
// 

import UIKit
import RxSwift

class ProjectManagerViewController: UIViewController {
    
    // MARK: - Properties
    
    
    private var collectionView: UICollectionView?
    private var viewModel = ProjectManagerViewModel()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewBackgroundColor()
        configureCollectionView()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureObservable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addCollectionViewBottomLine(borderWidth: 2, color: .systemGray5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        disposeBag = DisposeBag()
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
            forCellWithReuseIdentifier: CellIdentifier.collectionView
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
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -50
            ),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureObservable() {
        viewModel.alertError
            .subscribe(onNext: {
                self.presentAlert(error: $0)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Objective-C Methods

extension ProjectManagerViewController {
    @objc private func rightBarButtonTapped(sender: UIView) {
        let todoDetailViewController = TodoDetailViewController()
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        
        todoDetailViewController.set(
            todo: nil,
            viewModel: viewModel
        )
                cellIdentifier: CellIdentifier.collectionView,
        
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
    
    private func presentAlert(error: Error) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let rootViewController = sceneDelegate.window?.rootViewController as? UINavigationController else { return }
        
        var errorMessage: String
        
        switch error {
        case TodoError.emptyTitle:
            errorMessage = "Title을 입력해주세요."
        default:
            errorMessage = error.localizedDescription
        }
        
        let alertController = UIAlertController(
            title: "Error",
            message: errorMessage,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: "확인",
            style: .cancel
        )
        
        alertController.addAction(action)
        
        rootViewController.presentedViewController?.present(alertController, animated: true)
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
                for: indexPath
              ) as? ProjectManagerCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.set(
            status: status,
            categorizedTodoList: categoriedTodoList,
            viewModel: viewModel
        )
        
        return cell
    }
}
