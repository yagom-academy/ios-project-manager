//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/21.
//

import UIKit

final class TableViewCell: UITableViewCell {

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
        configureLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        titleStackView.addArrangedSubview(titleLabel)
        bodyStackView.addArrangedSubview(bodyLabel)
        deadlineStackView.addArrangedSubview(deadlineLabel)
        
        contentView.addSubview(titleStackView)
        contentView.addSubview(bodyStackView)
        contentView.addSubview(deadlineStackView)
    }
    
    private func configureLayout() {
        let width = contentView.frame.height / 3.0
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleStackView.bottomAnchor.constraint(equalTo: bodyStackView.topAnchor, constant: -8),
            titleStackView.heightAnchor.constraint(equalToConstant: width),
    
            bodyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            bodyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            bodyStackView.bottomAnchor.constraint(equalTo: deadlineStackView.topAnchor, constant: -8),
            bodyStackView.heightAnchor.constraint(equalToConstant: width),
            
            deadlineStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            deadlineStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            deadlineStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            deadlineStackView.heightAnchor.constraint(equalToConstant: width)
        ])
    }
    
    private func configureLabel() {
        titleLabel.text = "테스트타이틀"
        bodyLabel.text = "테스트바디"
        deadlineLabel.text = "테스트데드라인"
    }
}
