//
//  WorkCollectionViewControllerDelegate.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/23.
//

import UIKit

protocol WorkCollectionViewControllerDelegate: AnyObject {
    func workCollectionViewController(id: UUID)
    func workCollectionViewController(moveWork id: UUID, toStatus status: WorkViewModel.WorkStatus, rect: CGRect)
}

final class WorkCollectionViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<WorkViewModel.WorkStatus, WorkViewModel.Work>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WorkViewModel.WorkStatus, WorkViewModel.Work>
    
    let status: WorkViewModel.WorkStatus
    let viewModel: WorkViewModel
    
    weak var delegate: WorkCollectionViewControllerDelegate?
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var workDataSource: DataSource?
    
    init(status: WorkViewModel.WorkStatus, viewModel: WorkViewModel) {
        self.status = status
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureDataSource()
        applySnapshot()
        addUpdateSnapshotObserver()
        configureLongPressGesture()
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .lightGray
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = workDataSource
        collectionView.register(WorkCell.self,
                                forCellWithReuseIdentifier: WorkCell.identifier)
        collectionView.register(HeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {
            [weak self] (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let section: NSCollectionLayoutSection
            var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
            
            configuration.headerMode = .supplementary
            configuration.trailingSwipeActionsConfigurationProvider = self?.addSwipeActions
            
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
    
    private func addSwipeActions(for indexPath: IndexPath?) -> UISwipeActionsConfiguration? {
        guard let indexPath = indexPath,
              let id = workDataSource?.itemIdentifier(for: indexPath)?.id else { return nil }
        
        let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
        let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { _, _, completion in
            NotificationCenter.default.post(name: .workDeleted, object: id)
            completion(false)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureDataSource() {
        workDataSource = DataSource(collectionView: collectionView) { [weak self]
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
        
        if let currentStatus = WorkViewModel.WorkStatus.allCases.first(where: { $0.title == status.title }) {
            snapshot.appendSections([currentStatus])
            let works = viewModel.works.filter { $0.status == status.title }
            snapshot.appendItems(works, toSection: currentStatus)
        }
        
        workDataSource?.apply(snapshot, animatingDifferences: false)
        
        guard let headerView = collectionView.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader).first as? HeaderReusableView else { return }
        
        configureHeaderView(headerView)
    }

    private func addUpdateSnapshotObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applySnapshot),
            name: .worksChanged,
            object: nil
        )
    }
}

// MARK: - UICollectionView Delegate
extension WorkCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = workDataSource?.itemIdentifier(for: indexPath)?.id else { return }

        delegate?.workCollectionViewController(id: id)
    }
}

// MARK: - UIGestureRecognizer Delegate
extension WorkCollectionViewController: UIGestureRecognizerDelegate {
    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))

        longPressGesture.delegate = self
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc private func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: collectionView)

        if gestureRecognizer.state == .began {
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath),
                  let id = workDataSource?.itemIdentifier(for: indexPath)?.id,
                  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let rect = collectionView.convert(cell.frame, to: window)
            
            delegate?.workCollectionViewController(moveWork: id,
                                                   toStatus: status,
                                                   rect: rect)
        }
    }
}
