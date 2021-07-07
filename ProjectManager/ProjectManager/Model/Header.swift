//
//  Header.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/06/30.
//

import UIKit

class Header: UITableViewHeaderFooterView {
    
    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureContents() {
        
        title.font = UIFont.preferredFont(forTextStyle: .title1)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -100),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
}
