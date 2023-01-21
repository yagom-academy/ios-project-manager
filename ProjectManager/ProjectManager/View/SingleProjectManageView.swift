//
//  SingleProjectManageView.swift
//  ProjectManager
//
//  Created by jin on 1/13/23.
//

import UIKit

class SingleProjectManageView: UIView {

    private let header: HeaderView = {
        let header = HeaderView()
        header.backgroundColor = .systemGray6
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()

    private let tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    weak var delegate: UITableViewDelegate? {
        get {
            return tableView.delegate
        }
        set {
            tableView.delegate = newValue
        }
    }

    weak var dataSource: UITableViewDataSource? {
        get {
            return tableView.dataSource
        }
        set {
            tableView.dataSource = newValue
        }
    }

    // MARK: - LifeCycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI settings

    private func configureUI() {
        self.backgroundColor = .orange
        addSubview(header)
        addSubview(tableView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.topAnchor),
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            header.heightAnchor.constraint(equalToConstant: 70)
        ])

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    // MARK: - Setters

    func setHeaderText(text: String) {
        header.setTitle(text)
    }

    func setHeaderItemCount(count: Int) {
        header.setItemCount(count)
    }

    func register(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCellWith(identifier: String) -> UITableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: identifier)
    }
}
