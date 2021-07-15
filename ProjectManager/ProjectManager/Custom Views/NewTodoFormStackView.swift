//
//  NewTodoFormStackView.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/05.
//

import UIKit

final class NewTodoFormStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 10
        translatesAutoresizingMaskIntoConstraints = false
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 5, left: 15, bottom: 20, right: 15)
    }
}
