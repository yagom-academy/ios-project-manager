//
//  HistoryView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/25.
//

import UIKit

final class HistoryView: UIView {
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpTableViews()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTableViews() {
        addSubview(historyTableView)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            historyTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            historyTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            historyTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
