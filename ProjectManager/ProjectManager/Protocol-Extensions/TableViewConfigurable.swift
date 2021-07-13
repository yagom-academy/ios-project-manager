//
//  TableViewConfigurable.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/07/13.
//

import UIKit

protocol TableViewConfigurable {
    var header: UIView { get set }
    var headerLabel: UILabel { get set }
    var countLabel: UILabel { get set }
    var countView: UIView { get set }
}

extension TableViewConfigurable {
    
    func addSubViews() {
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
    }
    
    func configureViews(tableView: UITableView) {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: tableView.topAnchor),
            header.heightAnchor.constraint(equalToConstant: 60),
            header.widthAnchor.constraint(equalToConstant: 100),
            
            headerLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),

            countView.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 10),
            countView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            countView.widthAnchor.constraint(equalToConstant: 25),
            countView.heightAnchor.constraint(equalToConstant: 25),

            countLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor)
        ])
    }
}
