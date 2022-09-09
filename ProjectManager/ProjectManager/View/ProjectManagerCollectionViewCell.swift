//
//  ProjectManagerCollectionViewCell.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

import UIKit
import RxSwift
import RxCocoa

class ProjectManagerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var statusType: TodoStatus?
    private var disposeBag = DisposeBag()
    private var categorizedTodoList: Observable<[Todo]>? {
        didSet {
            configureObservable()
        }
    }
    
    private let tableViewCellIdentifier = "todoListCell"
    private var tableView: UITableView?
    
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
        let initialTableView = UITableView(frame: bounds, style: .plain)
        
        if #available(iOS 15, *) {
            initialTableView.sectionHeaderTopPadding = 0
        }
        initialTableView.backgroundColor = .systemGray6
        initialTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        initialTableView.register(
            TodoListTableViewCell.self,
            forCellReuseIdentifier: tableViewCellIdentifier
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
        
        categorizedTodoList?
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: tableViewCellIdentifier,
                    cellType: TodoListTableViewCell.self
                )
            ) { _, item, cell in
                cell.set(by: item)
                let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.popoverMoveTo))
                cell.addGestureRecognizer(longPressGestureRecognizer)
            }
            .disposed(by: disposeBag)
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
        rootViewController.present(popoverAlertController, animated: true)
    }
}

// MARK: - PopoverAlert Methods

extension ProjectManagerCollectionViewCell {
    private func generatePopoverAlertController(_ tableView: UITableView, _ indexPath: IndexPath) -> UIAlertController {
        let popoverAlertController = UIAlertController()
        
        addAlertActions(to: popoverAlertController, indexPath: indexPath)
        settingPopoverView(of: popoverAlertController, indexPath: indexPath)
        
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
                self?.moveToButtonTapped(from: currentStatus, indexPath: indexPath, to: selectedStatus)
            }
            
            alertController.addAction(newAction)
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
        print("\(currentStatus)로 부터 \(indexPath.row)번째 셀에서 \(destinationStatus)버튼 눌림!!")
    }
}

// MARK: - UITableViewDelegate

extension ProjectManagerCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rootViewController = self.window?.rootViewController else { return }
        
        let todoDetailViewController = TodoDetailViewController()
        todoDetailViewController.todoData = categorizedTodoList?.map { $0[indexPath.row] }
        
        let todoDetailNavigationController = UINavigationController(rootViewController: todoDetailViewController)
        rootViewController.present(todoDetailNavigationController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let statusType = self.statusType else { return nil }
        
        let headerView = TableSectionHeaderView()
        headerView.titleLabel.text = statusType.upperCasedString
        
        categorizedTodoList?
            .map { "\($0.count)" }
            .bind(to: headerView.countLabel.rx.text)
            .disposed(by: disposeBag)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            print("스와이프 제스쳐 Delete 감지됨!")
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - Setter Methods

extension ProjectManagerCollectionViewCell {
    func set(status: TodoStatus, categorizedTodoList: Observable<[Todo]>) {
        self.statusType = status
        self.categorizedTodoList = categorizedTodoList
    }
}
