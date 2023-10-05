//
//  ListTitleCell.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/25.
//

import UIKit

final class ListTitleCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        
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
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            countLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 22.5),
            countLabel.heightAnchor.constraint(equalToConstant: 22.5)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        countLabel.layer.cornerRadius = countLabel.bounds.width / 2
        countLabel.clipsToBounds = true
    }
    
    func setModel(title: String, count: Int) {
        titleLabel.text = title
        countLabel.text = String(count)
    }
}
