//
//  TodoView.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/18.
//

import UIKit

class DoListView: UIStackView {
    enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    private let mainViewModel: MainViewModel
    private let scheduleType: ScheduleType
    private lazy var headerView = TodoHeaderView()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(dataSource: UICollectionViewDiffableDataSource<Section, Schedule>? = nil,
         viewModel: MainViewModel,
         type: ScheduleType) {
        self.dataSource = dataSource
        self.mainViewModel = viewModel
        self.scheduleType = type
        super.init(frame: .zero)
        
        configureUI()
        configureStackView()
        configureDataSource()
        configureHeaderViewTitle()
        setupViewModelBind()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
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
    
    private func configureStackView() {
        self.axis = .vertical
        self.distribution = .fill
    }
    
    private func configureDataSource() {
        self.collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.identifier)
        self.dataSource = UICollectionViewDiffableDataSource<Section, Schedule> (collectionView: self.collectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell else { return nil
            }
            let schedule = self.mainViewModel.todoSchedules.value[indexPath.row]
            cell.configureUI()
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    private func applySnapshot() {
        var  snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mainViewModel.schedule())
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureHeaderViewCountLabel() {
        switch scheduleType {
        case .todo:
            headerView.configureCountLabel(count: mainViewModel.todoSchedules.value.count)
        case .doing:
            headerView.configureCountLabel(count: mainViewModel.doingSchedules.value.count)
        case .done:
            headerView.configureCountLabel(count: mainViewModel.doneSchedules.value.count)
        }
    }
    
    private func setupViewModelBind() {
        switch scheduleType {
        case .todo:
            mainViewModel.todoSchedules.bind { schedule in
                self.applySnapshot()
                self.configureHeaderViewCountLabel()
            }
        case .doing:
            mainViewModel.doingSchedules.bind { schedule in
                self.applySnapshot()
                self.configureHeaderViewCountLabel()
            }
        case .done:
            mainViewModel.doneSchedules.bind { schedule in
                self.applySnapshot()
                self.configureHeaderViewCountLabel()
            }
        }
    }
    
    private func configureHeaderViewTitle() {
        headerView.configureTitle(title: scheduleType.title)
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
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [weak self] _, _, completion in
            self?.mainViewModel.deleteSchedule(indexPath: indexPath)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


