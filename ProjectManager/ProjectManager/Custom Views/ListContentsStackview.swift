//
//  ToDoStackView.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

class ListContentsStackview: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureListContentsStackView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureListContentsStackView() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
    }
}
