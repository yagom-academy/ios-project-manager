//
//  ListTitleCell.swift
//  ProjectManager
//
//  Created by 1 on 2023/09/25.
//

import UIKit

final class ListTitleCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setUpLabel()
        configureUI()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        countLabel.text = nil
    }
    
    private func setUpLabel() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    
    private func configureUI() {
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4),
            
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            countLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }

    func setModel(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = String(count)
    }
}
