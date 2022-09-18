//
//  ProjectManagerCollectionViewCell.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import UIKit
import RxSwift

class ProjectManagerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    

    private var viewModel: ProjectManagerViewModel?
    
    private var statusType: TodoStatus?
    private var categorizedTodoList: Observable<[Todo]>? {
        didSet {
            configureObservable()
        }
    }
    
    private var tableView: UITableView?
    
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
        
        self.tableView = initialTableView
    }
    
    private func configureHierarchy() {
        guard let tableView = self.tableView else { return }
        addSubview(tableView)
    }
    
    private func configureObservable() {
        guard let tableView = self.tableView else { return }
        
    }
}

// MARK: - Objective-C Methods

extension ProjectManagerCollectionViewCell {
    @objc private func popoverMoveTo(_ sender: Any) {
        guard let gesture = sender as? UILongPressGestureRecognizer,
              gesture.state == .began else { return }
        
        guard let rootViewController = self.window?.rootViewController,
              let cell = gesture.view as? UITableViewCell,
              let tableView = self.tableView,
              let indexPath = tableView.indexPath(for: cell) else { return }
        
        let popoverAlertController = generatePopoverAlertController(tableView, indexPath)
        rootViewController.present(
            popoverAlertController,
            animated: true
        )
    }
}

// MARK: - PopoverAlert Methods

extension ProjectManagerCollectionViewCell {
    private func generatePopoverAlertController(_ tableView: UITableView, _ indexPath: IndexPath) -> UIAlertController {
        let popoverAlertController = UIAlertController()
        
        addAlertActions(
            to: popoverAlertController,
            indexPath: indexPath
        )
        settingPopoverView(
            of: popoverAlertController,
            indexPath: indexPath
        )
        
        return popoverAlertController
    }
    
    private func addAlertActions(to alertController: UIAlertController, indexPath: IndexPath) {
        guard let currentStatus = self.statusType else { return }
        let statusList = TodoStatus.allCases.filter { $0 != currentStatus }
        
        statusList.forEach { selectedStatus in
            let newAction = UIAlertAction(
                title: "Move to \(selectedStatus.upperCasedString)",
                style: .default
            ) { [weak self] _ in
                self?.moveToButtonTapped(
                    from: currentStatus,
                    indexPath: indexPath,
                    to: selectedStatus
                )
            }
        let dataSource = RxTableViewSectionedAnimatedDataSource<DataSourceSection> { dataSource, tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.tableView,
                for: indexPath
            ) as? TodoListTableViewCell else { return UITableViewCell() }
            
            cell.set(by: item)
            
            return cell
        }
    }
    
    private func settingPopoverView(of alertController: UIAlertController, indexPath: IndexPath) {
        guard let selectedCellView = self.tableView?.cellForRow(at: indexPath) else { return }
        
        let popoverPresentationController = alertController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = selectedCellView
        popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: 0,
            width: selectedCellView.frame.width,
            height: selectedCellView.frame.height / 2
        )
        
        alertController.modalPresentationStyle = .popover
    }
    
    private func moveToButtonTapped(from currentStatus: TodoStatus, indexPath: IndexPath, to destinationStatus: TodoStatus) {
        viewModel?.changeStatusTodoData?.onNext((currentStatus, indexPath.row, destinationStatus))
        sectionSubject.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ProjectManagerCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rootViewController = self.window?.rootViewController else { return }
        
        let todoDetailViewController = TodoDetailViewController()
        todoDetailViewController.set(
            todo: categorizedTodoList?.map { $0[indexPath.row] },
            viewModel: viewModel
        )
        
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        rootViewController.present(
            todoDetailNavigationController,
            animated: true
        )
        
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let statusType = self.statusType else { return nil }
        
        let headerView = TableSectionHeaderView()
        headerView.set(
            by: categorizedTodoList,
            status: statusType
        )
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { _, _, completion in
            self.categorizedTodoList?
                .take(1)
                .subscribe(onNext: { self.viewModel?.deleteTodoData?.onNext($0[indexPath.row]) })
                .disposed(by: self.disposeBag)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Setter Methods

extension ProjectManagerCollectionViewCell {
    func set(status: TodoStatus, categorizedTodoList: Observable<[Todo]>, viewModel: ProjectManagerViewModel) {
        self.statusType = status
        self.categorizedTodoList = categorizedTodoList
        self.viewModel = viewModel
    }
}
