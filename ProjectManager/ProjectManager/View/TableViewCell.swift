//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/21.
//

import UIKit

final class TableViewCell: UITableViewCell {
    private let borderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = " "
        label.font = UIFont.systemFont(ofSize: 8)
        
        return label
    }()
    
    private let borderStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        
        return label
    }()
    
    private let deadlineLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let bodyStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let deadlineStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        borderStackView.addArrangedSubview(borderLabel)
        titleStackView.addArrangedSubview(titleLabel)
        bodyStackView.addArrangedSubview(bodyLabel)
        deadlineStackView.addArrangedSubview(deadlineLabel)
        contentView.addSubview(borderStackView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(bodyStackView)
        contentView.addSubview(deadlineStackView)
    }
    
    private func configureLayout() {
        let height: CGFloat = contentView.frame.height / 3.0
        
        NSLayoutConstraint.activate([
            borderStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            borderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            borderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            borderStackView.bottomAnchor.constraint(equalTo: titleStackView.topAnchor, constant: -8),
            
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleStackView.bottomAnchor.constraint(equalTo: bodyStackView.topAnchor, constant: -8),
            titleStackView.heightAnchor.constraint(equalToConstant: height),
            
            bodyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bodyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            bodyStackView.bottomAnchor.constraint(equalTo: deadlineStackView.topAnchor, constant: -8),
            bodyStackView.heightAnchor.constraint(equalToConstant: height),
            
            deadlineStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            deadlineStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deadlineStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            deadlineStackView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func configureLabel(text: ProjectManager) {
        titleLabel.text = text.title
        bodyLabel.text = text.body
        
        guard let deadline = text.deadline else {
            return
        }
        
        let isDeadlineOver: Bool = Date().compareToday(with: deadline)
        deadlineLabel.text = Date().converString(date: deadline)
        deadlineLabel.textColor = isDeadlineOver ? .red : .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        bodyLabel.text = nil
        deadlineLabel.text = nil
        deadlineLabel.textColor = UIColor.black
    }
}
