//
//  TaskListViewController.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/18.
//

import UIKit

import RxSwift
import RxCocoa

final class TaskListViewController: UIViewController {
    private enum Section {
        case main
    }
    private let kanbanBoardView = KanbanBoardView()
    private lazy var kanbanBoardDataSource: UICollectionViewDiffableDataSource = {
        return UICollectionViewDiffableDataSource<Section, KanbanBoardModel>(
            collectionView: kanbanBoardView
        ) { (collectionView, indexPath, cellModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: KanbanBoardCell.reuseIdentifier,
                for: indexPath) as? KanbanBoardCell else { return nil }
            
            cell.configure(tasks: cellModel.tasks, state: cellModel.state, delegate: self)
            
            return cell
        }
    }()
    private lazy var plusBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        
        return barButtonItem
    }()
    private var viewModel: TaskListViewModel
    private let viewWillAppearEvent = PublishRelay<Void>()
    private let indexPathToDelete = PublishRelay<IndexPath>()
    private let indexPathToLongPress = PublishRelay<IndexPath>()
    private let selectedTaskEvent = PublishRelay<IndexPath>()
    private let disposeBag = DisposeBag()
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewWillAppearEvent.accept(())
    }
    
    
}

private extension TaskListViewController {
    func setUI() {
        view.backgroundColor = .systemBackground
        navigationItem.setRightBarButton(plusBarButtonItem, animated: true)
        kanbanBoardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(kanbanBoardView)
        
        let safeArea = view.safeAreaLayoutGuide
        let spacing: CGFloat = 8

        NSLayoutConstraint.activate([
            kanbanBoardView.topAnchor.constraint(equalTo: safeArea.topAnchor,
                                           constant: spacing),
            kanbanBoardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor,
                                               constant: spacing),
            kanbanBoardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor,
                                                constant: -spacing),
            kanbanBoardView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,
                                              constant: -spacing),
        ])
    }
    
    func bindViewModel() {
        let input = TaskListViewModel.Input(viewWillAppearEvent: viewWillAppearEvent.asObservable(),
                                            createButtonTapEvent: plusBarButtonItem.rx.tap.asObservable(),
                                            indexPathToDelete: indexPathToDelete.asObservable(),
                                            indexPathToLongPress: indexPathToLongPress.asObservable(),
                                            selectedTaskEvent: selectedTaskEvent.asObservable())
        let output = viewModel.transform(from: input)
        output.kanbanBoardModels
            .asDriver()
            .drive(onNext: { [weak self] kanbanBoardModels in
                self?.apply(with: kanbanBoardModels)
            })
            .disposed(by: disposeBag)
    }
    
    func apply(with kanbanBoardModels: [KanbanBoardModel]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, KanbanBoardModel>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(kanbanBoardModels)
        
        kanbanBoardDataSource.apply(snapShot)
    }
}

extension TaskListViewController: KanbanBoardDelegate {
    func KanbanBoard(didSelectedAt indexPath: IndexPath) {
        selectedTaskEvent.accept(indexPath)
    }
    func kanbanBoard(didDeletedAt indexPath: IndexPath) {
        indexPathToDelete.accept(indexPath)
    }
    func kanbanBoard(didLongPressedAt indexPath: IndexPath) {
        indexPathToLongPress.accept(indexPath)
    }
}


