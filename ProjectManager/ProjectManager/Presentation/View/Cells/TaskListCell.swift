//
//  TaskListCell.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import UIKit

class TaskListCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EF_Diary", size: 20)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EF_Diary", size: 16)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let datelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "EF_Diary", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let taskVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 3
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        [titleLabel, bodyLabel, datelabel].forEach {
            taskVerticalStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(taskVerticalStackView)
        contentView.layer.cornerRadius = 8
        backgroundColor = .white
        
        NSLayoutConstraint.activate([
            taskVerticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            taskVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            taskVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            taskVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
    
    func configureUI(data: TaskViewModel) {
        titleLabel.text = data.title
        datelabel.text = data.date
        bodyLabel.text = data.body
    }
}
