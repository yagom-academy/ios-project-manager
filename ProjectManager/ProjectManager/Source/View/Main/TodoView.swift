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
    enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    private let headerView = TodoHeaderView()
    private var mainViewModel: MainViewModel?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(dataSource: UICollectionViewDiffableDataSource<Section, Schedule>? = nil,
         viewModel: MainViewModel) {
        self.dataSource = dataSource
        self.mainViewModel = viewModel
        super.init(frame: .zero)
        
        mainViewModel?.todoSchedules.bind(listener: { schedule in
            self.applySnapshot()
        })
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureDataSource() {
        self.collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.identifier)
        self.dataSource = UICollectionViewDiffableDataSource<Section, Schedule> (collectionView: self.collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell,
                  let schedule = self.mainViewModel?.todoSchedules.value[indexPath.row] else { return nil }
            
            cell.configureUI()
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    func applySnapshot() {
        guard let schedules = mainViewModel?.schedule() else { return }
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
            
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        
        return layout
    }
    
    private func makeSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath, let _ = dataSource?.itemIdentifier(for: indexPath) else { return nil }
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { _, _, completion in
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
