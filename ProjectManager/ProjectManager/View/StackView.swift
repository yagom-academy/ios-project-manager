//
//  StackView.swift
//  ProjectManager
//
//  Created by 이영우 on 2021/07/26.
//

import UIKit

class StackView: UIStackView {
    init(_ views: [UIView]) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .horizontal
        self.spacing = 10
        self.distribution = .fillEqually
        self.backgroundColor = .systemGray4
        for view in views {
            self.addArrangedSubview(view)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
