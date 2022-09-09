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
    
    var statusType: TodoStatus?
    private var categorizedTodoList: Observable<[Todo]>?
    private var disposeBag = DisposeBag()
    
    var viewModel: ProjectManagerViewModel? {
        didSet {
            guard let statusType = statusType else { return }
            categorizedTodoList = viewModel?.categorizedTodoList[statusType]
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
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Other Methods

extension ProjectManagerCollectionViewCell {
    private func generatePopoverAlertController(_ tableView: UITableView, _ indexPath: IndexPath) -> UIAlertController? {
        guard let selectedCellView = tableView.cellForRow(at: indexPath) else { return nil }
        
        let popoverAlertController = UIAlertController()
        let popoverPresentationController = popoverAlertController.popoverPresentationController
        let statusList = TodoStatus.allCases.filter { $0 != self.statusType }
        var actionList: [UIAlertAction] = []
        
        statusList.forEach { [weak self] status in
            let newAction = UIAlertAction(
                title: "Move to \(status.upperCasedString)",
                style: .default
            ) { _ in
                guard let statusType = self?.statusType else { return }
                self?.moveToButtonTapped(from: statusType, indexPath: indexPath, to: status)
            }
            actionList.append(newAction)
        }
        
        actionList.forEach { action in
            popoverAlertController.addAction(action)
        }

        popoverAlertController.modalPresentationStyle = .popover
        popoverPresentationController?.permittedArrowDirections = .up
        popoverPresentationController?.sourceView = selectedCellView
        popoverPresentationController?.sourceRect = CGRect(
            x: 0,
            y: 0,
            width: selectedCellView.frame.width,
            height: selectedCellView.frame.height / 2
        )
        
        return popoverAlertController
    }
    
    private func moveToButtonTapped(from currentStatus: TodoStatus,
                                    indexPath: IndexPath,
                                    to destinationStatus: TodoStatus) {
        print("\(currentStatus)로 부터 \(indexPath.row)번째 셀에서 \(destinationStatus)버튼 눌림!!")
    }
}

// MARK: - UITableViewDelegate

extension ProjectManagerCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rootViewController = self.window?.rootViewController,
              let popoverAlertController = generatePopoverAlertController(
                tableView,
                indexPath
              ) else { return }
        
        rootViewController.present(popoverAlertController, animated: true)
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
