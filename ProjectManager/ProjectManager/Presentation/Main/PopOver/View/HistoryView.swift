//
//  HistoryView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import UIKit

final class HistoryView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpTableViews()
        setUpLayout()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTableViews() {
        addSubview(tableView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func registerCell() {
        tableView.register(HistoryCell.self, forCellReuseIdentifier: "\(HistoryCell.self)")
        tableView.tableFooterView = UIView()
    }
}
