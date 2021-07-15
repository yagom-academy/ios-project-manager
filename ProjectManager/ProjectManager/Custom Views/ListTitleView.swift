//
//  TitleView.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

final class ListTitleView: UIView {
    
    let title = UILabel()
    let count = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureListTitleView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureListTitleView() {
        backgroundColor = .systemGray6
        addSubview(title)
        addSubview(count)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        count.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            title.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            title.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            count.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            count.leadingAnchor.constraint(equalTo: title.layoutMarginsGuide.trailingAnchor, constant: 10),
            count.widthAnchor.constraint(equalToConstant: 25),
            count.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
