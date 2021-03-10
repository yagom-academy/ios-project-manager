//
//  ListCollectionViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    private let tableViewHeaderHeight: CGFloat = 40
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListItemTableViewCell.self, forCellReuseIdentifier: ListItemTableViewCell.identifier)
        tableView.backgroundColor = .lightGray
        tableView.separatorStyle = .none
        return tableView
    }()
    private let headerTitleLabel: UILabel = {
        let headerTitleLabel = UILabel()
        headerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerTitleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        headerTitleLabel.text = "TODO"
        return headerTitleLabel
    }()
    private let cellCountLabel: UILabel = {
        let cellCountLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        cellCountLabel.translatesAutoresizingMaskIntoConstraints = false
        cellCountLabel.backgroundColor = .black
        cellCountLabel.textColor = .white
        cellCountLabel.textAlignment = .center
        cellCountLabel.font = .preferredFont(forTextStyle: .headline)
        cellCountLabel.layer.masksToBounds = true
        cellCountLabel.layer.cornerRadius = cellCountLabel.frame.width * 0.5
        cellCountLabel.text = "1"
        return cellCountLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        contentView.addSubview(tableView)
        configureAutoLayout()
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView DataSource
extension ListCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListItemTableViewCell.identifier, for: indexPath) as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

// MARK: - TableView Delegate
extension ListCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableViewHeaderHeight))
        headerView.backgroundColor = .white
        configureAboutHeaderViewAutoLayout(headerView: headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableViewHeaderHeight
    }
    
    func configureAboutHeaderViewAutoLayout(headerView: UIView) {
        headerView.addSubview(headerTitleLabel)
        headerView.addSubview(cellCountLabel)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),

            cellCountLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cellCountLabel.leadingAnchor.constraint(equalTo: headerTitleLabel.trailingAnchor, constant: 10),
            cellCountLabel.widthAnchor.constraint(equalToConstant: 30),
            cellCountLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
