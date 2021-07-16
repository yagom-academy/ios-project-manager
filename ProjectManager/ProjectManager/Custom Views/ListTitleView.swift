//
//  TitleView.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

final class ListTitleView: UIView {
    
    let titleLabel = UILabel()
    let countLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureListTitleView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureListTitleView() {
        backgroundColor = .systemGray6
        addSubview(titleLabel)
        addSubview(countLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.layoutMarginsGuide.trailingAnchor, constant: 10),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            countLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
