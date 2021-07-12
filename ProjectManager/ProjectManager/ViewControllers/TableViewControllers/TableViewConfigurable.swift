//
//  TableViewConfigurable.swift
//  ProjectManager
//
//  Created by 김찬우 on 2021/07/13.
//

import UIKit

protocol TableViewConfigurable {
    var tableView: UITableView { get set }
    var header: UIView { get set }
    var headerLabel: UILabel { get set }
    var countLabel: UILabel { get set }
    var countView: UIView { get set }
}

extension TableViewConfigurable {
    mutating func setViews() {
        header = {
            let header = UIView()
            header.backgroundColor = .systemGray6
            header.translatesAutoresizingMaskIntoConstraints = false

            return header
        }()

        headerLabel = {
            let label = UILabel(frame: header.bounds)
            label.text = "TODO"
            label.font = UIFont.preferredFont(forTextStyle: .title1)
            label.textAlignment = .left
            label.translatesAutoresizingMaskIntoConstraints = false

            return label
        }()

        countView = {
            let countView = UIView()
            countView.backgroundColor = .black
            countView.translatesAutoresizingMaskIntoConstraints = false
            countView.clipsToBounds = true
            countView.layer.cornerRadius = 11.5

            return countView
        }()

        countLabel = {
            let count = UILabel(frame: header.bounds)
            count.textColor = .white
            count.text = "\(Task.todoList.count)"
            count.font = UIFont.preferredFont(forTextStyle: .title3)
            count.textAlignment = .center
            count.translatesAutoresizingMaskIntoConstraints = false

            return count
        }()
    }
    
    func addSubViews() {
        header.addSubview(headerLabel)
        countView.addSubview(countLabel)
        header.addSubview(countView)
    }
    
    func configureViews() {
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
