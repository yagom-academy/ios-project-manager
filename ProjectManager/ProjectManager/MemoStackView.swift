//
//  ToDoStackView.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

class MemoStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureStackView() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
    }
}
