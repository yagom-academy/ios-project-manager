//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

import UIKit

final class ToDoListTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    func setupUI() {
        self.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            bodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 5),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setModel(title: String, date: String, body: String, isPast: Bool) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
        
        if isPast {
            dateLabel.textColor = .systemRed
        }
    }
    
    override func prepareForReuse() {
        titleLabel.textColor = .black
        bodyLabel.textColor = .black
        dateLabel.textColor = .black
    }
    
}
