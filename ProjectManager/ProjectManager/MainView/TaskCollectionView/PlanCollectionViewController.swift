//
//  PlanCollectionViewController.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/25.
//

import UIKit
import Combine

final class PlanCollectionViewController: UIViewController {
    private enum Section: Hashable {
        case main(count: Int)
    }
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Plan.ID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Plan.ID>
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout())
    
    private var dataSource: DataSource?
    private var viewModel: PlanListViewModel
    private var cancellables = Set<AnyCancellable>()
    private let dateFormatter: DateFormatter
    private var currentLongPressedCell: PlanCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRootView()
        configureCollectionViewLayout()
        configureDataSource()
        configureCollectionView()
        bindState()
        setupLongTapGestureRecognizer()
    }
    
    init(viewModel: PlanListViewModel, dateFormatter: DateFormatter) {
        self.viewModel = viewModel
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .supplementary
            config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
                guard let self else {
                    return UISwipeActionsConfiguration()
                }
                
                let actionHandler: UIContextualAction.Handler = { [weak self] action, view, completion in
                    guard let plan = self?.viewModel.plan(at: indexPath.row) else {
                        return
                    }
                    
                    self?.viewModel.delete(planID: plan.id)
                    completion(true)
                }
                
                let action = UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: actionHandler
                )
                
                return UISwipeActionsConfiguration(actions: [action])
            }
            
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(70)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
            section.boundarySupplementaryItems = [sectionHeader]
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)

            return section
        }

        return layout
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: cellProvider)
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath
            ) as? HeaderView else {
                fatalError("Could not dequeue sectionHeader:")
            }
            
            let viewModel = HeaderViewModel(
                titleText: self.viewModel.planWorkState.text,
                badgeCount: self.viewModel.planList.count
            )
            sectionHeader.provide(viewModel: viewModel)
            
            return sectionHeader
        }
    }
    
    private func cellProvider(_ collectionView: UICollectionView, indexPath: IndexPath, identifier: Plan.ID) -> UICollectionViewCell? {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PlanCell.identifier,
            for: indexPath
        ) as? PlanCell

        guard let plan = self.viewModel.planList.filter({ $0.id == identifier }).first else {
            return cell
        }

        let planCellViewModel = PlanCellViewModel(plan: plan, dateFormatter: dateFormatter)
        cell?.provide(viewModel: planCellViewModel)

        return cell
    }
    
    private func configureCollectionView() {
        collectionView.register(PlanCell.self, forCellWithReuseIdentifier: PlanCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    private func bindState() {
        viewModel.planCreated
            .sink { [weak self] in
                self?.applyLatestSnapshot()
            }
            .store(in: &cancellables)
        
        viewModel.planUpdated
            .sink { [weak self] planID in
                self?.reloadItems(id: planID)
            }
            .store(in: &cancellables)
        
        viewModel.planDeleted
            .sink { [weak self] planID in
                self?.deleteItems(id: planID)
            }
            .store(in: &cancellables)
    }
    
    private func applyLatestSnapshot() {
        let planIDList = viewModel.planList.map { $0.id }
        
        let section = Section.main(count: viewModel.planList.count)
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(planIDList, toSection: section)
        dataSource?.apply(snapshot)
    }
    
    private func reloadItems(id: UUID) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        snapshot.reloadItems([id])
        dataSource?.apply(snapshot)
    }
    
    private func deleteItems(id: UUID) {
        guard var snapshot = dataSource?.snapshot() else { return }
        
        snapshot.deleteItems([id])
        dataSource?.apply(snapshot)
    }
}

// MARK: - CollectionViewDelegate 기능
extension PlanCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let plan = viewModel.plan(at: indexPath.row)
        
        let detailViewModel = DetailViewModel(from: plan, mode: .update)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        detailViewController.configureViewModelDelegate(with: viewModel as? DetailViewModelDelegate)
        
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        
        self.present(navigationController, animated: true)
    }
}

// MARK: - GestureRecognizer 관련 기능
extension PlanCollectionViewController {
    private func setupLongTapGestureRecognizer() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delaysTouchesBegan = true
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc
    private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: collectionView)
        
        if gestureRecognizer.state == .began {
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = collectionView.cellForItem(at: indexPath) as? PlanCell else {
                return
            }
            
            self.currentLongPressedCell = cell
        }
        
        if gestureRecognizer.state == .ended {
            guard let indexPath = collectionView.indexPathForItem(at: location),
                  let cell = self.currentLongPressedCell else {
                return
            }
            
            if cell == collectionView.cellForItem(at: indexPath) {
                guard let plan = viewModel.plan(at: indexPath.row),
                      let mainViewController = self.parent as? MainViewController
                else {
                    return
                }
                
                let changeWorkStateViewModel = ChangeWorkStateViewModel(from: plan)
                changeWorkStateViewModel.delegate = mainViewController.mainViewModel
                
                let changeWorkStateViewController = ChangeWorkStateViewController(
                    viewModel: changeWorkStateViewModel
                )
                changeWorkStateViewController.modalPresentationStyle = .popover
                changeWorkStateViewController.popoverPresentationController?.sourceView = cell
                changeWorkStateViewController.preferredContentSize = CGSize(width: 300, height: 120)
                changeWorkStateViewController.popoverPresentationController?.sourceRect = CGRect(
                    origin: CGPoint(x: cell.bounds.midX, y: cell.bounds.midY),
                    size: .zero
                )
                changeWorkStateViewController.popoverPresentationController?.permittedArrowDirections = .down
                
                self.present(changeWorkStateViewController, animated: true)
            }
        }
    }
}
