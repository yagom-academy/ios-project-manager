//
//  WorkCollectionView.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/23.
//

import UIKit

final class WorkCollectionView: UICollectionView {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkStatus, Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkStatus, Work>
    
    let status: String
    let viewModel: WorkViewModel
    private var workDataSource: DataSource?
    
    init(status: String, viewModel: WorkViewModel) {
        self.status = status
        self.viewModel = viewModel
        
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        configureCollectionView()
        configureDataSource()
        applySnapshot()
        
        let layout = createLayout()
        collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        backgroundColor = .lightGray
        
        register(WorkCell.self, forCellWithReuseIdentifier: WorkCell.identifier)
        register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {
            [weak self] (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            
            configuration.headerMode = .supplementary
            configuration.trailingSwipeActionsConfigurationProvider = self?.makeSwipeActions
            
            section = NSCollectionLayoutSection.list(using: configuration,
                                                     layoutEnvironment: environment)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.interGroupSpacing = 8
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            headerSupplementary.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [headerSupplementary]
//            section.orthogonalScrollingBehavior = .none
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = workDataSource?.itemIdentifier(for: indexPath)?.id else { return nil }
        
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) {
            [weak self] _, _, completion in
            self?.viewModel.removeWork(id: id)
            self?.applySnapshot()
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource() {
        workDataSource = DataSource(collectionView: self) {
            (collectionView, indexPath, work) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(title: work.title, body: work.body, deadline: "\(work.deadline)")
            
            return cell
        }
        
        workDataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as? HeaderReusableView else {
                    return UICollectionReusableView()
                }
                
                headerView.configure(title: self?.status ?? "", count: "3")
                
                return headerView
            } else {
                return nil
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = Snapshot()
        
        if let currentStatus = WorkStatus.allCases.first(where: { $0.title == status }) {
            snapshot.appendSections([currentStatus])
            let works = viewModel.works.filter { $0.status == status }
            snapshot.appendItems(works, toSection: currentStatus)
        }
        
        workDataSource?.apply(snapshot, animatingDifferences: false)
    }
}
