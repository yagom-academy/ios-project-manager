//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit
import MobileCoreServices

protocol ListTableViewDelegate: AnyObject {
    func presentEditView(listItemDetailViewController: ListItemDetailViewController)
}

class ListTableView: UITableView {
    private var statusType: ItemStatus
    weak var listTableViewDelegate: ListTableViewDelegate?
    private lazy var headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 60))
    
    init(statusType: ItemStatus) {
        self.statusType = statusType
        super.init(frame: .zero, style: .plain)
        setUpDelegate()
        configureTableView()
        configureTableHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpDelegate() {
        dataSource = self
        delegate = self
        
        switch statusType {
        case .todo:
            ItemList.shared.todoDelegate = self
        case .doing:
            ItemList.shared.doingDelegate = self
        case .done:
            ItemList.shared.doneDelegate = self
        }
    }
    
    private func configureTableView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.identifier)
        self.backgroundColor = .systemGray6
        self.separatorStyle = .none
    }
    
    private func configureTableHeaderView() {
        headerView.fillLabels(statusType: statusType)
        self.tableHeaderView = headerView
    }
    
    private func reloadHeaderCellCountLabel() {
        headerView.reloadCellCountLabel(statusType: statusType)
    }
    
    @objc private func reloadTableView(_ noti: Notification) {
        let status = noti.userInfo?["statusType"] as? ItemStatus
        if self.statusType == status {
            self.reloadData()
            reloadHeaderCellCountLabel()
        }
    }
}

// MARK: - TableView DataSource
extension ListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemList.shared.countListItem(statusType: statusType)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        let todo = ItemList.shared.getItem(statusType: statusType, index: indexPath.row)
        cell.fillLabelsText(item: todo, statusType: statusType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ItemList.shared.removeItem(statusType: statusType, index: indexPath.row)
            configureTableHeaderView()
        }
    }
}

// MARK: - TableView Delegate
extension ListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItemDetailViewController = ListItemDetailViewController(statusType: statusType, detailViewType: .edit, itemIndex: indexPath.row)
        self.listTableViewDelegate?.presentEditView(listItemDetailViewController: listItemDetailViewController)
    }
}

// MARK: - ItemListUpdateDelegate
extension ListTableView: ItemListUpdateDelegate {
    func insertRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        insertRows(at: [indexPath], with: .automatic)
    }

    func deleteRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        deleteRows(at: [indexPath], with: .automatic)
    }

    func updateRow(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - Drag & Drop
extension ListTableView {
    func dragItem(indexPath: IndexPath) -> [UIDragItem] {
        let item = ItemList.shared.getItem(statusType: statusType, index: indexPath.row)
        guard let data = try? JSONEncoder().encode(item) else { return [] }
        let itemProvider = NSItemProvider()
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            completion(data, nil)
            DispatchQueue.main.async {
                ItemList.shared.removeItem(statusType: self.statusType, index: indexPath.row)
                self.reloadHeaderCellCountLabel()
            }
            return nil
        }
        return [dragItem]
    }
    
    func dropItem(coordinator: UITableViewDropCoordinator) {
        let insertionIndex: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            insertionIndex = indexPath
        } else {
            let section = self.numberOfSections - 1
            let row = self.numberOfRows(inSection: section)
            insertionIndex = IndexPath(row: row, section: section)
        }
        
        for item in coordinator.items {
            item.dragItem.itemProvider.loadDataRepresentation(forTypeIdentifier: kUTTypePlainText as String) { (data, error) in
                guard let data = data, error == nil else {
                    return
                }
                guard let todo = try? JSONDecoder().decode(Todo.self, from: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    ItemList.shared.insertItem(statusType: self.statusType, index: insertionIndex.row, item: todo)
                    self.reloadHeaderCellCountLabel()
                }
            }
        }
    }
}
