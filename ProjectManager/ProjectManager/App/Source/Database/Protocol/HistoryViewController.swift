//
//  HistoryViewController.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/29.
//

import UIKit

final class HistoryViewController: UIViewController {
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, History>
    
    private var dataSource: DataSource?
    private lazy var collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createListLayout())
        
        collectionView.backgroundColor = .systemGray6
        collectionView.register(HistoryCell.self,
                                forCellWithReuseIdentifier: HistoryCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func createListLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            let config = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            
            return section
        }
        
        return layout
    }
    
    private func setupView() {
        view.addSubview(collectionView)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        setupCollectionViewConstraints()
        setupDataSource()
    }
    
    private func setupCollectionViewConstraints() {
        let safe = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safe.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safe.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, history in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HistoryCell.reuseIdentifier,
                for: indexPath
            ) as? HistoryCell else { return UICollectionViewCell() }
            
            cell.configure(history)
            
            return cell
        }
    }
}
