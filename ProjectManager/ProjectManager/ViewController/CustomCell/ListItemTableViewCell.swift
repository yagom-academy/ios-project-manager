//
//  ListTableViewCell.swift
//  ProjectManager
//
//  Created by sole on 2021/03/09.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }
    private let contentsContainerView: UIView = {
        let contentsContainerView = UIView()
        contentsContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentsContainerView.backgroundColor = .white
        return contentsContainerView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        return titleLabel
    }()
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .preferredFont(forTextStyle: .caption1)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .gray
        return descriptionLabel
    }()
    private let deadLineLabel: UILabel = {
        let deadLineLabel = UILabel()
        deadLineLabel.translatesAutoresizingMaskIntoConstraints = false
        deadLineLabel.font = .preferredFont(forTextStyle: .caption1)
        return deadLineLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        titleLabel.text = "title"
        descriptionLabel.text = "descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel descriptionLabel"
        deadLineLabel.text = "deadLine"
        configureContentsContainerView()
        configureAutoLayout()
    }
    
    private func configureContentsContainerView() {
        contentsContainerView.addSubview(titleLabel)
        contentsContainerView.addSubview(descriptionLabel)
        contentsContainerView.addSubview(deadLineLabel)
        contentView.addSubview(contentsContainerView)
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            contentsContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentsContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contentsContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentsContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            
            titleLabel.topAnchor.constraint(equalTo: contentsContainerView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentsContainerView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentsContainerView.leadingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentsContainerView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentsContainerView.leadingAnchor),
            
            deadLineLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            deadLineLabel.trailingAnchor.constraint(equalTo: contentsContainerView.trailingAnchor),
            deadLineLabel.leadingAnchor.constraint(equalTo: contentsContainerView.leadingAnchor),
            deadLineLabel.bottomAnchor.constraint(equalTo: contentsContainerView.bottomAnchor, constant: -10)
        ])
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        deadLineLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        deadLineLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        deadLineLabel.text = ""
        descriptionLabel.textColor = .black
        deadLineLabel.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
