//
//  MainLeftTableViewCell.swift
//  ProjectManager
//
//  Created by yonggeun Kim on 2023/01/13.
//

import UIKit

class MainLeftTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "MainLeftTableViewCell"
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Private Methods
    
    private func configureLayout() {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
