//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private var toDoListViewModel: TodoListViewModel = TodoListViewModel()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    private lazy var mainCollectionViewModel = MainCollectionViewModel(
        collectionView: collectionView,
        cellReuseIdentifier: TodoCell.identifier
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRootView()
        configureCollectionViewLayout()
        configureCollectionView()
        mainCollectionViewModel.update()
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        layoutConfiguration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalWidth(0.2))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                   heightDimension: .fractionalHeight(1))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                           subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .absolute(50.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
            
            return section
        }, configuration: layoutConfiguration)
        
        return layout
    }
    
    private func configureRootView() {
        view.backgroundColor = .systemGray4
        view.addSubview(collectionView)
    }
    
    private func configureCollectionViewLayout() {
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        collectionView.register(TodoCell.self, forCellWithReuseIdentifier: TodoCell.identifier)
        collectionView.isScrollEnabled = false
        
        do {
            collectionView.dataSource = try mainCollectionViewModel.makeDataSource()
        } catch {
            print(error.localizedDescription)
        }
        
        collectionView.delegate = self
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("move DetailView")
    }
}
