//
//  ListViewCell.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import UIKit

final class ListViewCell: UICollectionViewCell {
    static let identifier = "cell"
    
    private let listContentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .systemGray3
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddSubviews()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContent(with toDoList: ToDoModel) {
        titleLabel.text = toDoList.title
        descriptionLabel.text = toDoList.description
        deadLineLabel.text = DateFormatter.shared.stringDate(from: toDoList.deadLine)
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
            listContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
