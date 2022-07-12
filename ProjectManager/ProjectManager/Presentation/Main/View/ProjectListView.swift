//
//  ProjectListView.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/07.
//

import UIKit

final class ProjectListView: UIStackView {
    let headerView: HeaderView
    let tableView = UITableView()
    
    init(title: String) {
        self.headerView = HeaderView(title: title)
        super.init(frame: .zero)
        
        layout()
        registerCell()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        axis = .vertical
        addArrangedSubview(headerView)
        addArrangedSubview(tableView)
    }
    private func registerCell() {
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "\(ProjectCell.self)")
        tableView.tableFooterView = UIView()
    }
    
    func compose(projectCount: String) {
        headerView.countLabel.text = projectCount
    }
}

final class HeaderView: UIView {
    private let listTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.sizeToFit()
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        
        func round() {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 20
        }
        
        func text() {
            label.textColor = .white
            label.text = "0"
            label.textAlignment = .center
            label.font = .preferredFont(forTextStyle: .body)
        }
        
        round()
        text()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        setUpLayout()
        setUpTitle(title: title)
        backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(listTitleLabel)
        addSubview(countLabel)
        
        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            listTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            listTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: listTitleLabel.topAnchor, constant: 2),
            countLabel.bottomAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: -2),
            countLabel.leadingAnchor.constraint(equalTo: listTitleLabel.trailingAnchor, constant: 10),
            countLabel.widthAnchor.constraint(equalTo: countLabel.heightAnchor, constant: 2)
        ])
    }
    
    private func setUpTitle(title: String) {
        listTitleLabel.text = title
    }
    
    func setUpCountLabel(count: Int) {
        countLabel.text = String(count)
    }
}
