//
//  Header.swift
//  ProjectManager
//
//  Created by 이성노 on 2021/06/30.
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
        
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
//            title.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -100),
//            title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -10),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
}
