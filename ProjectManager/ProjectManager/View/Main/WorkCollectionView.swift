//
//  WorkCollectionView.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/23.
//

import UIKit

protocol WorkCollectionViewDelegate: AnyObject {
    func workCollectionView(_ collectionView: WorkCollectionView, id: UUID)
}

final class WorkCollectionView: UICollectionView {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkStatus, Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkStatus, Work>
    
    weak var workDelegate: WorkCollectionViewDelegate?
    let status: WorkStatus
    let viewModel: WorkViewModel
    private var workDataSource: DataSource?
    
    init(status: WorkStatus, viewModel: WorkViewModel) {
        self.status = status
        self.viewModel = viewModel
        
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        configureCollectionView()
        configureDataSource()
        applySnapshot()
        addObserver()
        
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
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
            section.interGroupSpacing = 8
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            headerSupplementary.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [headerSupplementary]
            
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
            
            let handler = {
                self?.viewModel.currentID = id
                self?.viewModel.removeWork()
                self?.applySnapshot()
            }
            
            NotificationCenter.default.post(name: .requestingAlert, object: handler)
            completion(false)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource() {
        workDataSource = DataSource(collectionView: self) { [weak self]
            (collectionView, indexPath, work) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier, for: indexPath) as? WorkCell,
                  let isExceededDeadline = self?.viewModel.checkExceededDeadline(work.deadline) else {
                return UICollectionViewCell()
            }
            
            let deadline = work.deadline.applyDateFormatter()
            
            cell.configure(title: work.title, body: work.body, deadline: deadline, isExceededDeadline: isExceededDeadline)
            
            return cell
        }
        
        workDataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderReusableView.identifier, for: indexPath) as? HeaderReusableView else {
                    return UICollectionReusableView()
                }
                
                self?.configureHeaderView(headerView)
                
                return headerView
            } else {
                return nil
            }
        }
    }
    
    private func configureHeaderView(_ headerView: HeaderReusableView) {
        let cellCount = viewModel.fetchWorkCount(of: status)

        headerView.configure(title: status.title, count: "\(cellCount)")
    }
    
    @objc private func applySnapshot() {
        var snapshot = Snapshot()
        
        if let currentStatus = WorkStatus.allCases.first(where: { $0.title == status.title }) {
            snapshot.appendSections([currentStatus])
            let works = viewModel.works.filter { $0.status == status.title }
            snapshot.appendItems(works, toSection: currentStatus)
        }
        
        workDataSource?.apply(snapshot, animatingDifferences: false)
        
        guard let headerView = visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? HeaderReusableView else { return }
        
        configureHeaderView(headerView)
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applySnapshot),
            name: .updateSnapShot,
            object: nil
        )
    }
}

extension WorkCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = workDataSource?.itemIdentifier(for: indexPath)?.id else { return }

        workDelegate?.workCollectionView(self, id: id)
    }
}
