//
//  DescriptionCell.swift
//  ProjectManager
//
//  Created by 1 on 2023/09/26.
//

import UIKit

final class DescriptionCell: UITableViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let dateLabel: UILabel = {
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
        bodyLabel.text = nil
        dateLabel.text = nil
    }
    
    private func setUpLabel() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            
            dateLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func setModel(title: String, body: String, date: String) {
        titleLabel.text = title
        bodyLabel.text = body
        dateLabel.text = date
    }
}
