//  ProjectManager - ToDoCell.swift
//  created by zhilly on 2023/01/17

import UIKit

class ToDoCell: UITableViewCell, ReusableView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemGray
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentsStackView.addArrangedSubview(titleLabel)
        contentsStackView.addArrangedSubview(bodyLabel)
        contentsStackView.addArrangedSubview(deadlineLabel)
        contentView.addSubview(contentsStackView)
        
        NSLayoutConstraint.activate([
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(title: String, body: String, deadline: String) {
        titleLabel.text = title
        bodyLabel.text = body
        deadlineLabel.text = deadline
    }
}
