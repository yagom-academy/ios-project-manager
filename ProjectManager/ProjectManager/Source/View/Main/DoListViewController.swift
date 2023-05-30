//
//  DoListViewController.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/18.
//

import UIKit
import Combine

class DoListViewController: UIViewController {
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, Schedule>?
    private let mainViewModel: MainViewModel
    private let scheduleType: ScheduleType
    private let listStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    private lazy var headerView = TodoHeaderView()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(dataSource: UICollectionViewDiffableDataSource<Section, Schedule>? = nil,
         viewModel: MainViewModel,
         type: ScheduleType) {
        self.dataSource = dataSource
        self.mainViewModel = viewModel
        self.scheduleType = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHeaderViewTitle()
        configureDataSource()
        setupViewModelBind()
        configureLongPressGesture()
        configureCollectionViewDelegate()
    }
    
    private func configureUI() {
        collectionView.backgroundColor = .lightGray
        self.view.addSubview(listStackView)
        self.listStackView.addArrangedSubview(headerView)
        self.listStackView.addArrangedSubview(collectionView)
        
        NSLayoutConstraint.activate([
            listStackView.topAnchor.constraint(equalTo: view.topAnchor),
            listStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 50),
            headerView.leadingAnchor.constraint(equalTo: listStackView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: listStackView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: listStackView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: listStackView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: listStackView.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Schedule> (collectionView: self.collectionView) { (collectionView, indexPath, schedule) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.identifier, for: indexPath) as? ScheduleCell else { return nil
            }
            
            cell.configureLabel(schedule: schedule)
            
            return cell
        }
    }
    
    private func applySnapshot(schedules: [Schedule]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Schedule>()
        snapshot.appendSections([.main])
        snapshot.appendItems(schedules)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureHeaderViewCountLabel(schedules: [Schedule]) {
        let count = schedules.count
        headerView.configureCountLabel(count: count)
    }
    
    private func setupViewModelBind() {
        switch scheduleType {
        case .todo:
            mainViewModel.$todoSchedules.sink {
                self.applySnapshot(schedules: $0)
                self.configureHeaderViewCountLabel(schedules: $0)
            }.store(in: &cancellables)
        case .doing:
            mainViewModel.$doingSchedules.sink {
                self.applySnapshot(schedules: $0)
                self.configureHeaderViewCountLabel(schedules: $0)
            }.store(in: &cancellables)
        case .done:
            mainViewModel.$doneSchedules.sink {
                self.applySnapshot(schedules: $0)
                self.configureHeaderViewCountLabel(schedules: $0)
            }.store(in: &cancellables)
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
        let deleteAction = UIContextualAction(style: .destructive, title: Namespace.delete) { [weak self] _, _, completion in
            guard let self else { return }
            self.mainViewModel.deleteSchedule(scheduleType: self.scheduleType, index: indexPath.row)
            completion(false)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func configureCollectionViewDelegate() {
        collectionView.delegate = self
    }
    
    private func presentPopover(touchedLocation: CGPoint, index: Int) {
        let alertController = createAlertController(index: index)
        let popover = alertController.popoverPresentationController
        
        popover?.sourceView = view
        popover?.sourceRect = CGRect(origin: touchedLocation, size: CGSize(width: 64, height: 64))
        present(alertController, animated: true)
    }
    
    private func createAlertController(index: Int) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        switch scheduleType {
        case .todo:
            alertController.addAction(makeAlertAction(title: Namespace.moveToDOING, index: index, toScheduleType: .doing))
            alertController.addAction(makeAlertAction(title: Namespace.moveToDONE, index: index, toScheduleType: .done))
        case .doing:
            alertController.addAction(makeAlertAction(title: Namespace.moveToTODO, index: index, toScheduleType: .todo))
            alertController.addAction(makeAlertAction(title: Namespace.moveToDONE, index: index, toScheduleType: .done))
        case .done:
            alertController.addAction(makeAlertAction(title: Namespace.moveToTODO, index: index, toScheduleType: .todo))
            alertController.addAction(makeAlertAction(title: Namespace.moveToDOING, index: index, toScheduleType: .doing))
        }
        
        return alertController
    }
    
    private func makeAlertAction(title: String, index: Int, toScheduleType: ScheduleType) -> UIAlertAction {
        UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self else { return }
            self.mainViewModel.move(fromIndex: index, from: self.scheduleType, to: toScheduleType)
        }
    }
}

extension DoListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modalViewController = ModalViewController(viewModel: mainViewModel,
                                                      modalType: .edit,
                                                      scheduleType: scheduleType,
                                                      index: indexPath.row)
        let modalNavigationController = UINavigationController(rootViewController: modalViewController)
        modalViewController.modalPresentationStyle = .formSheet
        modalViewController.preferredContentSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.7)
        
        present(modalNavigationController, animated: true, completion: nil)
    }
}

extension DoListViewController: UIGestureRecognizerDelegate {
    private func configureLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(pushLongPress(gestureRecognizer:)))
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.delaysTouchesBegan = true
        longPressGesture.delegate = self
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func pushLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: collectionView)
        guard gestureRecognizer.state == .began else { return }
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return }
        
        presentPopover(touchedLocation: location, index: indexPath.row)
    }
}
