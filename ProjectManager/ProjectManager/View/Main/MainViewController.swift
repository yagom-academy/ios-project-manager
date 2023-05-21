//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkStatus, Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkStatus, Work>
    
    private let viewModel = WorkViewModel()
    private var collectionView: UICollectionView?
    private var dataSource: DataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIOption()
        configureCollectionView()
        configureDataSource()
        applySnapshot()
        configureSwipeGesture()
    }
    
    private func configureUIOption() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(moveToAppendWork))
    }
    
    @objc private func moveToAppendWork() {
        let detailViewController = DetailViewController()
        detailViewController.configureAddMode()
        let navigationController = UINavigationController(rootViewController: detailViewController)
        
        self.present(navigationController, animated: true)
    }
}

// MARK: - Collection View Setting
extension MainViewController {
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(WorkCell.self,
                                forCellWithReuseIdentifier: WorkCell.identifier)
        collectionView.register(HeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderReusableView.identifier)
        
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(20))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 4, bottom: 0, trailing: 4)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0),
                                                   heightDimension: .estimated(20))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.interGroupSpacing = 8
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0/3.0),
                                                    heightDimension: .absolute(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }, configuration: config)
        
        return layout
    }
    
    private func configureCollectionView() {
        collectionView = createCollectionView()
        
        guard let collectionView else { return }
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func configureDataSource() {
        guard let collectionView else { return }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(title: item.title, body: item.body, deadline: "\(item.deadline)")
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as? HeaderReusableView else {
                    return UICollectionReusableView()
                }
                
                let section = WorkStatus.allCases[indexPath.section]
                
                headerView.configure(title: section.title, count: "3")
                
                return headerView
            } else {
                return nil
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        
        WorkStatus.allCases.forEach { status in
            snapshot.appendSections([status])
            let works = viewModel.works.filter { $0.status == status.title }
            snapshot.appendItems(works, toSection: status)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension MainViewController: UIGestureRecognizerDelegate {
    private func configureSwipeGesture() {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        
        swipeGestureRecognizer.delegate = self
        swipeGestureRecognizer.direction = .left
        collectionView?.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            let location = gestureRecognizer.location(in: collectionView)
            
            guard let indexPath = collectionView?.indexPathForItem(at: location),
                  let id = dataSource?.itemIdentifier(for: indexPath)?.id else { return }
            
            viewModel.removeWork(id: id)
            applySnapshot()
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

