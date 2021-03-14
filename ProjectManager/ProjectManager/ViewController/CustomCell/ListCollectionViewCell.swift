//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

protocol ListItemDetailViewDelegate: class {
    func presentEditView(itemStatus: ItemStatus, index: Int)
}

class ListCollectionViewCell: UICollectionViewCell {
    var statusType: ItemStatus = .todo {
        didSet {
            configureTableHeaderView()
        }
    }
    static var identifier: String {
        return "\(self)"
    }
    weak var delegate: ListItemDetailViewDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegateDelegate()
        setUpContentView()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func delegateDelegate() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setUpContentView() {
        contentView.addSubview(tableView)
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureTableHeaderView() {
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .systemGray6
        headerView.fillHeaderViewText(itemStatus: statusType)
        tableView.tableHeaderView = headerView
    }
}

// MARK: - TableView DataSource
extension ListCollectionViewCell: UITableViewDataSource {
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
        }
    }
}

// MARK: - TableView Delegate
extension ListCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.presentEditView(itemStatus: statusType, index: indexPath.row)
    }
}
