//
//  ProjectManagerCollectionViewCell.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import UIKit
import RxSwift
import RxGesture
import RxDataSources

final class ProjectManagerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
        
    private var viewModel: CellViewModelType?
    private var statusType: TodoStatus? {
        didSet {
            configureViewModel()
            bindViewModel()
        }
    }
    
    private var tableView: UITableView?
    private var configureTableViewHeader: (() -> UIView)?
    
    private var deleteSubject = PublishSubject<Int>()
    private var detailViewDoneButtonSubject = PublishSubject<(Todo?, IndexPath)>()
    private var moveToSubject = PublishSubject<(UITableView, UIGestureRecognizer)>()
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTableView()
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
}

// MARK: - Configure Methods

extension ProjectManagerCollectionViewCell {
    private func configureViewModel() {
        guard let statusType = statusType else { return }
        
        switch statusType {
        case .todo:
            viewModel = TodoViewModel(statusType: statusType)
        case .doing:
            viewModel = DoingViewModel(statusType: statusType)
        case .done:
            viewModel = DoneViewModel(statusType: statusType)
        }
    }
    
    private func configureTableView() {
        let initialTableView = UITableView(
            frame: bounds,
            style: .plain
        )
        
        if #available(iOS 15, *) {
            initialTableView.sectionHeaderTopPadding = 0
        }
        initialTableView.backgroundColor = .systemGray6
        initialTableView.separatorInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        initialTableView.register(
            TodoListTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.tableView
        )
        initialTableView.delegate = self
        
        tableView = initialTableView
    }
    
    private func configureHierarchy() {
        guard let tableView = tableView else { return }
        addSubview(tableView)
    }
}

// MARK: - Bind Method

extension ProjectManagerCollectionViewCell {
    private func bindViewModel() {
        guard let tableView = tableView,
              let statusType = statusType else { return }
        
        let input = CellViewInput(
            doneAction: detailViewDoneButtonSubject,
            deleteAction: deleteSubject,
            moveToAction: moveToSubject
        )
        guard let output = viewModel?.transform(viewInput: input) else { return }
        
        configureTableViewHeader = { [weak self] in
            guard let self = self else { return UIView() }
            
            let headerView = TableSectionHeaderView()
            headerView.set(title: statusType.upperCasedString)
            
            output.categorizedTodoList?
                .map { "\($0.count)" }
                .bind(to: headerView.countLabel.rx.text)
                .disposed(by: self.disposeBag)
            
            return headerView
        }
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<DataSourceSection> { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.tableView,
                for: indexPath
            ) as? TodoListTableViewCell else { return UITableViewCell() }
            
            cell.set(by: item)
            
            return cell
        }
        
        dataSource.canEditRowAtIndexPath = { dataSource, index -> Bool in true }
        tableView.rx.itemDeleted
            .bind { [weak self] indexPath in
                self?.deleteSubject.onNext(indexPath.row)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.longPressGesture()
            .subscribe(onNext: { [weak self] gestureRecognizer in
                self?.moveToSubject.onNext((tableView, gestureRecognizer))
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                guard let self = self,
                      let rootViewController = self.window?.rootViewController else { return }
                
                let todoDetailViewController = TodoDetailViewController()
                let categorizedTodoList = output.categorizedTodoList?
                    .filter { $0.count > indexPath.row }
                
                output.categorizedTodoList?
                    .subscribe(onNext: { _ in
                        todoDetailViewController.dismiss(animated: true)
                    })
                    .disposed(by: self.disposeBag)
                
                categorizedTodoList?
                    .map { $0[indexPath.row].title }
                    .bind(to: todoDetailViewController.titleTextField.rx.text)
                    .disposed(by: self.disposeBag)
                
                categorizedTodoList?
                    .map { $0[indexPath.row].createdAt }
                    .bind(to: todoDetailViewController.datePicker.rx.date)
                    .disposed(by: self.disposeBag)
                
                categorizedTodoList?
                    .map { $0[indexPath.row].body }
                    .bind(to: todoDetailViewController.bodyTextView.rx.text)
                    .disposed(by: self.disposeBag)
                
                todoDetailViewController.doneButton.rx.tap
                    .map { todoDetailViewController.getCurrentTodoInfomation() }
                    .subscribe(onNext: { todo in
                        self.detailViewDoneButtonSubject.onNext((todo, indexPath))
                    })
                    .disposed(by: self.disposeBag)
                
                todoDetailViewController.cancelButton.rx.tap
                    .subscribe(onNext: { todoDetailViewController.dismiss(animated: true) })
                    .disposed(by: self.disposeBag)
                
                rootViewController.present(
                    UINavigationController(rootViewController: todoDetailViewController),
                    animated: true
                )
                
                tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        let sectionSubject = BehaviorSubject<[DataSourceSection]>(value: [])
        
        output.categorizedTodoList?
            .map { DataSourceSection(
                headerTitle: statusType.upperCasedString,
                items: $0
            )}
            .subscribe(onNext: { sectionSubject.onNext([$0]) })
            .disposed(by: disposeBag)
        
        sectionSubject.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        output.moveToAlertController?
            .subscribe(onNext: { [weak self] in
                guard let rootViewController = self?.window?.rootViewController else { return }
                rootViewController.present($0, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ProjectManagerCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = configureTableViewHeader?()
        return headerView
    }
}

// MARK: - Setter Methods

extension ProjectManagerCollectionViewCell {
    func set(statusType: TodoStatus) {
        self.statusType = statusType
    }
}
