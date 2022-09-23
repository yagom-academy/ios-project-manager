//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by Finnn.
//  Copyright © Finnn. All rights reserved.
// 

import UIKit
import RxSwift
import RxCocoa

final class ProjectManagerViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView?
    private var viewModel = ProjectManagerViewModel()
    
    private var detailViewDoneButtonTapped = PublishSubject<Todo?>()
    private let addTodoButton = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: nil,
        action: nil
    )
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground.withAlphaComponent(0.98)
        configureCollectionView()
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addCollectionViewBottomLine(borderWidth: 2, color: .systemGray5)
    }
}

// MARK: - Configure Methods

extension ProjectManagerViewController {
    private func configureNavigationBar() {
        title = ProjectManager.title
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = addTodoButton
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
        
        collectionView = initialCollectionView
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
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        guard let collectionView = collectionView else { return }
        
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
}

// MARK: - Bind Method

extension ProjectManagerViewController {
    private func bindViewModel() {
        guard let collectionView = collectionView else { return }
        
        let input = ProjectManagerViewInput(doneAction: detailViewDoneButtonTapped)
        let output = viewModel.transform(viewInput: input)
        
        let items = Observable.just(TodoStatus.allCases)
        items
            .bind(to: collectionView.rx.items(
                cellIdentifier: CellIdentifier.collectionView,
                cellType: ProjectManagerCollectionViewCell.self
            )) { index, viewModel, cell in
                guard let status = TodoStatus(rawValue: index) else { return }
                cell.set(statusType: status)
            }
            .disposed(by: disposeBag)
        
        addTodoButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                let todoDetailViewController = TodoDetailViewController()
                let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
                
                todoDetailViewController.doneButton.rx.tap
                    .subscribe(onNext: {
                        let currentTodo = todoDetailViewController.getCurrentTodoInfomation()
                        self.detailViewDoneButtonTapped.onNext(currentTodo)
                    })
                    .disposed(by: self.disposeBag)
                
                output.allTodoList?
                    .subscribe(onNext: { _ in
                        todoDetailViewController.dismiss(animated: true)
                    })
                    .disposed(by: self.disposeBag)
                
                output.errorAlertContoller?
                    .subscribe(onNext: { alertController in
                        todoDetailViewController.present(alertController, animated: true)
                    })
                    .disposed(by: self.disposeBag)
                
                self.present(todoDetailNavigationController, animated: true)
            })
            .disposed(by: disposeBag)
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
