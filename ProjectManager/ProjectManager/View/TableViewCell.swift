//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "tableViewCell"
    
    private let listContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.backgroundColor = .white
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var deadLineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func prepareForReuse() {
        deadLineLabel.textColor = .black
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAddSubviews()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(with toDoList: ProjectModel) {
        titleLabel.text = toDoList.title
        descriptionLabel.text = toDoList.description
        deadLineLabel.text = DateFormatter.shared.stringDate(from: toDoList.deadLine)
        if toDoList.ispastdue == true {
            deadLineLabel.textColor = .red
        }
    }
    
    private func configureAddSubviews() {
        contentView.addSubview(listContentView)
        listContentView.addArrangedSubview(titleLabel)
        listContentView.addArrangedSubview(descriptionLabel)
        listContentView.addArrangedSubview(deadLineLabel)
    }
    
    private func configureConstraint() {
        NSLayoutConstraint.activate([
            listContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
