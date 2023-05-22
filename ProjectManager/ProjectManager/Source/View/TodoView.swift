//
//  TodoView.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/18.
//

import UIKit

class TodoView: DoListView {}

class DoingView: DoListView {}

class DoneView: DoListView {}

class DoListView: UIStackView {
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    
    private let headerView = TodoHeaderView()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureCompositionalLayout())
        
        collectionView.showsVerticalScrollIndicator = false
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    func configureDataSource(schedule: Schedule) {
        
        self.collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: "cell")
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, Schedule> (collectionView: self.collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ScheduleCell else { return nil }
            
            cell.configureUI()
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    func applySnapshot(schedules: [Schedule]) {
        var  snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.main])
        snapshot.appendItems(schedules)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    func configureUI() {
        collectionView.backgroundColor = .lightGray
        self.addArrangedSubview(headerView)
        self.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureStackView() {
        self.axis = .vertical
        self.distribution = .fill
    }
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            configuration.showsSeparators = true
            
            configuration.trailingSwipeActionsConfigurationProvider = self.makeSwipeActions
            
            
            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            
            section.interGroupSpacing = 20
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let _ = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

