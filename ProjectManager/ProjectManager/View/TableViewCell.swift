//
//  TableViewCell.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/21.
//

import UIKit

final class TableViewCell: UITableViewCell {
    static let identifier: String = "TableViewCellIdentifier"
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
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: bodyStackView.topAnchor),
            
            bodyStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyStackView.bottomAnchor.constraint(equalTo: deadlineStackView.topAnchor),
            
            deadlineStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deadlineStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deadlineStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func configureLabel() {
        titleLabel.text = "테스트타이틀"
        bodyLabel.text = "테스트바디"
        deadlineLabel.text = "테스트데드라인"
    }
}
