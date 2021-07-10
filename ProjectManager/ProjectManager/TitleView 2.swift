//
//  TitleView.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

class MemoTitleView: UIView {
    
    let title = UILabel()
    let count = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configurView() {
        title.text = "Header"
        count.text = "5"
        
        addSubview(title)
        addSubview(count)
        title.translatesAutoresizingMaskIntoConstraints = false
        count.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            count.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            count.leadingAnchor.constraint(equalTo: title.layoutMarginsGuide.trailingAnchor, constant: -8)
        ])
    }
}
