//  ProjectManager - HistoryCell.swift
//  created by zhilly on 2023/01/27

import UIKit

final class HistoryCell: UITableViewCell, ReusableView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .systemGray3
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(createdAtLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            createdAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            createdAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            createdAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            createdAtLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    func configure(with item: History) {
        titleLabel.text = item.title
        createdAtLabel.text = item.createdAt
    }
}
