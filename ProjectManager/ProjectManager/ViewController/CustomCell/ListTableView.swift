//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

protocol ListTableViewDelegate: class {
    func presentEditView(listItemDetailViewController: ListItemDetailViewController)
}

class ListTableView: UITableView {
    var statusType: ItemStatus
    weak var listTableViewDelegate: ListTableViewDelegate?

    init(statusType: ItemStatus) {
        self.statusType = statusType
        super.init(frame: .zero, style: .plain)
        dataSource = self
        delegate = self
        configureTableView()
        configureTableHeaderView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("reloadTableView"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.identifier)
        self.backgroundColor = .systemGray6
        self.separatorStyle = .none
    }
    
    func configureTableHeaderView() {
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 60))
        headerView.fillHeaderViewText(itemStatus: statusType)
        self.tableHeaderView = headerView
    }
    
    @objc func reloadTableView(_ noti: Notification) {
        let status = noti.userInfo?["statusType"] as? ItemStatus
        if self.statusType == status {
            self.reloadData()
            configureTableHeaderView()
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
            tableView.deleteRows(at: [indexPath], with: .fade)
            configureTableHeaderView()
        }
    }
}

// MARK: - TableView Delegate
extension ListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItemDetailViewController = ListItemDetailViewController()
        listItemDetailViewController.configureDetailView(itemStatus: statusType, type: .edit, index: indexPath.row)
        self.listTableViewDelegate?.presentEditView(listItemDetailViewController: listItemDetailViewController)
    }
}
