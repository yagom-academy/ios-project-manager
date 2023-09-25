//
//  ListViewCell.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/25.
//

import UIKit

final class ListViewCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "책상정리"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray3
        label.text = "책상정리..."
        label.numberOfLines = 3
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.text = "2023. 09. 25."
        
        return label
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        backgroundColor = .brown
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
    }
}

// MARK: - Configure UI
extension ListViewCell {
    private func configureUI() {
        addSubviews()
        setUpContentStackViewConstraints()
    }
    
    private func addSubviews() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(contentStackView)
    }
    
    private func setUpContentStackViewConstraints() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor
                .constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor
                .constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentStackView.topAnchor
                .constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor
                .constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
